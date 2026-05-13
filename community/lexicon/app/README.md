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

## Internationalization

Entries can include a `locale` field when the listing is intended for a
particular language or regional audience. App publishers can add
`profileLocalization` records for authoritative localized names, descriptions,
links, images, and Web App Manifest URIs.

Publishers SHOULD use a lowercase BCP 47 language tag as the record rkey (e.g.
`fr`, `pt-br`, `zh-hant`) so the rkey acts as a natural uniqueness key per
locale. Publishers SHOULD publish at most one `profileLocalization` record per
locale. If duplicate records exist for the same locale, consumers SHOULD prefer
the one with the most recent `updatedAt` or `createdAt` timestamp.

## Rich app metadata

Records can include an `images` array (up to 24 items) for icons, logos, hero
images, screenshots, banners, social cards, app store visuals, ads, or other
directory media. Each item MUST include `alt` text and exactly one of `image`
(an ATProto blob) or `uri` (a remote URL). Consumers MUST ignore items that
carry neither or both. `purpose` and `aspectRatio` are optional per item;
multiple items may share the same `purpose` (e.g. several screenshots or hero
variants are all valid).

Records may also include `webManifestUri` to point at an HTTPS Web App Manifest.
Manifests can prefill or augment install behavior, icons, screenshots,
language, and platform or form-factor metadata without making manifests the only
way to describe visual assets.

## Trust and verification

`profileDid` in an `entry` record is an unverified claim made by whoever
published the entry — it is not proof that the named DID endorses the listing.
Directories SHOULD treat it purely as a hint. Before labeling an entry
"official" or "verified", directories SHOULD:

1. Fetch the record at `at://<profileDid>/community.lexicon.app.profile/self`
   and prefer its fields over any data copied into the entry.
2. Verify ownership out of band using methods such as `rel=me`, `.well-known`
   resources, or other trust policies.

Verification is otherwise intentionally out of scope for these records.
