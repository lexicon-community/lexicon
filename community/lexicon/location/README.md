# community.lexicon.location

This set of Lexicon schemas describes a set of ways to represent geographic locations in ATProtocol.

## Guidelines on using coordinate values

* Geographic coordinates used in this Lexicon are stored as *strings*, due to the exclusion of floating-point numbers from the ATProtocol data model. That should be fine -- every programming language has functions for turning floats into strings and back.

* Latitude and longitude coordinates are given in *decimal* degrees north and east, respectively. Avoid using minutes and seconds (i.e. DMS) format.

* Coordinates south of the equator or west of the prime meridian should be given as *negative* values. Avoid using direction indicators (i.e. N, S, E, W).

* Because ATGeo coordinates have fixed precision, consider carefully how many decimal places you need for a latitude or longitude value. Five decimal places (0.00001º) provides a precision of a little more than a meter.

* Altitude values should be given in *meters* above mean sea level. Avoid using US feet or other linear measures.

* All geographic coordinates used in the location lexicon are referenced to the WGS84 geoid and datum. (If you don't know what this means, don't worry about it.)


## Geographic representations

* `geo`: Represents a simple latitude/longitude point. This is probably the easiest lexicon to work with.

* `address`: Represents a simple, generic street address. Does not include coordinates *per se*.

* `hthree`: Represents a hexagonal cell using the [H3 grid system](https://h3geo.org/). H3 allows you to specify a geographic region at a desired level of precision using a simple string value. There are Free Software bindings for working with H3 grids in [a variety of languages](https://h3geo.org/docs/community/bindings).

* `fsq`: Represents a place from the Foursquare Venue dataset using its dataset ID. This schema may (should?) be deprecated in the future.

Note that all geographic representations include a `name` field. This allows developers to attach names to geographic coordinates, when no other place attribute information is needed.
