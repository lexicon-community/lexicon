# Places in ATGeo

## Scope

This document proposes a community Lexicon for geographic places (`community.lexicon.location.place`), along with explanatory detail about the design choices to date.

The Place Lexicon is intended *specifically* to aid ATProtocol application developers in incorporating place information in their applications, and to provide a means for interoperability between applications. The Place Lexicon is not intended to provide any kind of authoritative representation of geographic places outside of this scope, nor it is meant to be a comprehensive GIS data model.

## Representing Places with Lexicon

### Places have names, locations, and (sometimes) unique identifiers

The concept of a "place" in our world is a social and psychological one, so a precise definition of the term is difficult to provide. But we can note certain properties that allow us to identify specific places, and distinguish them from each other.

**Some places can be identified with just a name.** The name "Times Square, New York" unambiguously identifies a public place. Sometimes places are private, and are known only by name; for example, "Schuyler's House".

**Some places can be identified with just a geographic location.** If you have geographic coordinates, you can uniquely identify the place at those coordinates, even if you don't know what's there. In that case, a name can be an aid to identification, but might not be required. There are other ways to identify a geographic location, such as a street address, a postal code, a bounding box, or a global grid cell.

**Some places change location over time.** A museum might move to a different building, yet still be the same "place" in the eyes of the locals. Organizations that publish catalogs of places employ *authoritative, globally unique identifiers* for each place, to ensure that a given "place" can be identified and updated over time. These identifiers can be composed into URIs and used as global references.

So, as you can see, any place in the world might be identified by any combination of its name, its coordinates, and/or a GUID assigned by some authority. The more of these properties you have, the more durably you can identify a given place over time.

Therefore the `place` schema should include all three of these properties, but not require any of them.

### Places often have multiple names

**Sometimes a place has different names in different languages.** "Londres", "Londra", and "Лондон" are just three different linguistic variants for the name of the capital of the United Kingdom.

**Sometimes a place has alternate names or nicknames in the same language**. Consider "The Big Apple", "The Windy City", or "The City By The Bay". Some of these names are more "official" or more "widely used" than others.

**Sometimes the priority of naming is conventional, rather than official.** Consider the city of Ventura, California, which is officially known as "San Buenaventura", even though no one calls it that.

The `place#name` schema needs to support naming places in multiple languages and conventions, with a ranking scheme to indicate which names are more notable or important. Conventionally, a lower priority value will mean greater "importance". Language identification should follow ATProtocol norms.

Language code and priority can be omitted, if unknown.

The most important name by priority is the "primary name" that should be displayed by an application, in the absence of localization.

Most (if not all) `community.lexicon.location` spatial types include a `name` property. The application developer can always use this field instead, if they like. The `location.name` property, if present, should be the same as the place's primary name.

### Locations can be represented in various ways

**The simplest spatial geometry is a point**, and the latitude/longitude coordinate pair will always be the simplest way to identify a location unambiguously.

**Other location formats can be chosen for practical utility**, such as a street address that can be used for wayfinding.

**More complex geometries can be useful for different purposes**. A park could be located by a point within the park, or by a polygon that describes its boundaries. A road might be identified by a line string.

**We might want a place's location to be deliberately vague**, possibly for privacy or security reasons. A global grid system, such as H3, provides a way of describing locations with intentionally limited precision.

**Any spatial location might contain multiple places.** Consider a food court, which is a place, containing multiple restaurants, each their own place. All of these places might share a street address and/or be represented by the same point location.

The `place#location` schema needs to be a union of different location representations, to cover the range of anticipated use cases. The community will want to provide tooling to make the various representations accessible to applicatino developers.

### Places can have other attributes, too

Any authoritative database of places will include non-geographic attributes about that place: What kind of place it is, what purposes does it serve, what its opening hours are, *et cetera*. 

Each authority that publishes such a database invariably has a structured attribute schema. These schemas can be translated, to one extent or another, into Lexicon.

### A gazetteer is just an index of an authoritative list of places

Traditionally, a gazetteer was just an index of place names, along with ancillary attributes. Here, however, we are expanding the idea of a *gazetteer* in the ATmosphere to mean "an authoritative database of places that can be represented using Lexicon schema and queried using XRPC".

Recall that any authoritative place database will include GUIDs and structured attributes for each place. If we assign a conventional NSID to each authoritative database, we can compose a globally-unique ATProto record key for each place in that database. This key can be used to fetch entire place records from a gazetteer service.

The convention for place record keys will be `<authority dataset NSID>:<authority place GUID>`. For the most part, the "authority NSID" will be conventionally assigned, rather than dictated by the authority (which may or may not know about ATProtocol and may or may not care).

### A place record is a set of assertions, not a claim on the truth

We have been using the term "authority" strictly in a "self-proclaimed" sense -- if you publish a database of places, you are explicitly claiming authority over what's included in that database.

However, **the Place Lexicon is meant to be used by ATProtocol applications to allow users to describe new places** and augment existing ones. The veracity of both authoritative and user-generated place records should always be regarded as contingent. Place records will be incomplete, fall out of date, contain erroneous information, or even be manipulated by bad actors.

### Place records can change over time

Both authoritative and user-generated **place records capture statements about the world at a particular point in time**. Developers should expect new or updated information to be published at various intervals about the places their applications make use of.

The `place` schema should include the ability to identify the publication date of a place record. Developers should have the freedom to decide which version of a record to use, based on use case.

### Place records can be coordinated

Often, we can identify the same real-world place across multiple authoritative databases. A gazetteer might publish a `sameAs` property as part of a place record that identifies the record keys for the same place from other datasets. The process of aligning place IDs across disparate geographic databases is known as "concordance".

## Referencing Places with Lexicon

### A Place reference is a subset of a Place record

The entire purpose of describing places in Lexicon is, ultimately, to enable developers to build applications that employ places as part of *some other* social web activity. Referencing a place in an application record is a fundamentally different assertion than describing that place, but the Lexicon components are basically the same.

Consider a social event application like Smoke Signal. We definitely want to be able to state that an event will occur at a specific place, by embedding a reference to that place in the event record.

That reference might include:

* The name(s) of the place, for display and searchability.
* The location of the place, for searchability and to enable wayfinding.
* Other attribute data, such as the type of place it is.
* The URI of the place, e.g. so we can generate event calendars for that place.

Take a step back and you'll see that this is basically *all* of the properties of the original place record. Therefore an embedded place reference should optionally include *any* property that the Place Lexicon supports.

### Which fields to embed in a Place reference?

The developer gets to decide which of those properties to include in each application post. Storing the place record URI ensures that, at a minimum, the latest details about that place can be fetched from the network.

However, an embedded place reference doesn't have to end there. Including more properties in the reference makes the record more robust to gazetteer failures, and possibly saves network round-trips when the record is used. However, this comes at the cost of making application records bulkier and more costly to sync and to work with.

### Strong References to Places

One additional property in the `place#ref` schema not present in the `place` schema is the CID field. With this CID link, a developer can preserve the specific revision of the place record being referenced, even if that record evolves over time.

## Open questions

### Record identifiers

The approach taken here is to embed both the authority dataset NSID and the dataset record ID into the `place` record key. This means that an AT-URI for a place might look like:

```
at://gazetteer.social/community.lexicon.location.place/org.foursquare.venue:12345
```

Where `gazetteer.social` is the hypothetical network address of one gazetteer service hosting the `org.foursquare.venue` dataset.

Is this the right approach? Or does it make more sense for `org.foursquare.venue` to be the name of the collection, and `12345` the record key?

### Table of proposed dataset NSIDs

Here are some possible authoritative dataset NSIDs for community use:

| Dataset | Proposed NSID | Notes |
|---------|---------------|-------------|
| OpenStreetMap Nominatim | `org.osm.places` | https://nominatim.org/ |
| Foursquare OS Places | `org.foursquare.places` | https://opensource.foursquare.com/os-places/ |
| Overture Maps Places | `org.overturemaps.places` | https://docs.overturemaps.org/guides/places/ | 
| Who's On First Venues | `org.whosonfirst.venue` | https://github.com/whosonfirst-data/whosonfirst-data-venue/ | 
| Wikidata | `org.wikidata.entity` | Wikidata place entities |

### Place taxonomy

The proposed schema is deliberately silent on the concept of "place type". One of the biggest lessons of the OpenStreetMap project has been to demonstrate that top-down place taxonomies tend to fail at global scale, either by being too precise or not precise enough, or by failing to capture important cross-cultural nuances. However, punting on this at the protocol level pushes the decision about how to identify and use place types down to the application developer. This creates a substantial conceptual burden for developer, and tends to lock their development into a specific authoritative data set. What to do?

### Signed place records

ATProtocol records are normally signed when stored in a repository. What does this mean for a gazetteer drawing from an third-party dataset?

### User safety

A developer guide to ATGeo needs to include a detailed discussion of how to inform and protect the safety of users and their spatial data.
