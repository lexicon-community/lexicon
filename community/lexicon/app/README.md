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

## Rich app metadata

Records can include an `images` array for icons, logos, hero images,
screenshots, banners, social cards, app store visuals, ads, or other directory
media. Each image includes alt text and either an ATProto blob or a hosted image
URI; purpose and aspect ratio are optional.

Records may also include `webManifestUri` to point at a Web App Manifest.
Manifests can prefill or augment install behavior, icons, screenshots,
language, and platform or form-factor metadata without making manifests the only
way to describe visual assets.

## Verification

Verification is intentionally out of scope for these records. Directories and
clients can verify ownership out of band using methods such as `rel=me`,
`.well-known` resources, or other trust policies.
