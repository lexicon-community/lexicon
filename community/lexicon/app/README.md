# community.lexicon.app

This set of Lexicon schemas describes apps built on or for the AT Protocol.

## Records

* `profile`: A canonical app profile published by the app's DID at rkey
  `self`.

* `profileLocalization`: Locale-specific metadata for a canonical app profile.
  These records should be published by the same DID as the profile. Publishers
  should use normalized BCP 47 language tags as rkeys when possible, such as
  `fr` or `pt-BR`; consumers should trust the record's `locale` field over the
  rkey.

* `entry`: A community or third-party app listing. Any account can publish an
  entry, including entries for apps they do not own.

## Canonical profiles

Entries can name a `profileDid`. Consumers can derive the canonical profile URI
from that DID:

```text
at://<profileDid>/community.lexicon.app.profile/self
```

An entry without `profileDid` should be treated as a standalone third-party
listing. A `profileDid` is a pointer to where a canonical profile may exist, not
proof of ownership or verification by itself.

## Links

Records use `links` for all external and protocol destinations. The first link
should be the primary app destination. A Web App Manifest is represented as a
normal link with a known role:

```json
{
  "role": "community.lexicon.app.defs#linkRoleWebManifest",
  "label": "Web App Manifest",
  "uri": "https://example.com/manifest.webmanifest"
}
```

Distribution URLs, such as App Store, Play Store, and F-Droid listings, also
belong in `links` with their corresponding roles.

## Discovery signals

Use `platforms` for platform filtering, `lexicons` for AT Protocol
interoperability, and `tags` for freeform discovery or category labels. Tags
should not duplicate platforms, lexicon interop, or language fields.

The `lexicons` field is self-declared and may be incomplete. Directories can use
it to answer questions like "which apps consume or produce this lexicon?", but
should not treat it as verified/audited truth.

The `accountIndicators` field lists records whose presence in an account can
suggest that the account probably uses the app. For example:

```json
{
  "collection": "org.passingreads.actor.profile",
  "rkey": "self"
}
```

This is only a heuristic usage signal. It does not prove active use, consent, or
endorsement.

## Internationalization

Entries can include `langs` to describe the human language of the entry text,
matching the convention used by `app.bsky.feed.post`. This describes the
listing, not every language supported by the app UI.

App publishers can add `profileLocalization` records for authoritative localized
names, descriptions, links, images, and discovery tags.

Publishers SHOULD use a lowercase BCP 47 language tag as the localization record
rkey (e.g. `fr`, `pt-br`, `zh-hant`) so the rkey acts as a natural uniqueness
key per locale. Publishers SHOULD publish at most one `profileLocalization`
record per locale. If duplicate records exist for the same locale, consumers
SHOULD prefer the one with the most recent `updatedAt` or `createdAt` timestamp.

## Rich app metadata

Records can include an `images` array (up to 24 items) for icons, logos, hero
images, screenshots, banners, social cards, app store visuals, ads, or other
directory media. Each item MUST include `alt` text and exactly one of `image`
(an ATProto blob) or `uri` (a remote URL). Consumers MUST ignore items that
carry neither or both. `purpose` and `aspectRatio` are optional per item;
multiple items may share the same `purpose` (e.g. several screenshots or hero
variants are all valid). If no known image purpose fits, omit `purpose`.

Web App Manifests can still prefill or augment install behavior, icons,
screenshots, language, and platform or form-factor metadata, but they are linked
through `links` rather than modeled as a top-level field.

## Trust and verification

`profileDid` in an `entry` record is an unverified claim made by whoever
published the entry -- it is not proof that the named DID endorses the listing.
Directories SHOULD treat it purely as a hint. Before labeling an entry
"official" or "verified", directories SHOULD:

1. Fetch the record at `at://<profileDid>/community.lexicon.app.profile/self`
   and prefer its fields over any data copied into the entry.
2. Verify ownership out of band using methods such as `rel=me`, `.well-known`
   resources, or other trust policies.

Verification is otherwise intentionally out of scope for these records.

## Deferred ideas

License metadata and backend deployment/self-hosting signals are useful follow-up
ideas, but are intentionally left out of this v1 proposal.
