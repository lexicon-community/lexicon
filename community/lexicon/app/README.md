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
links, logos, and Web App Manifest URIs.

## Rich app metadata

Records may include `webManifestUri` to point at a Web App Manifest. Manifests
can describe install behavior, icons, screenshots, language, and platform or
form-factor metadata without storing large promotional media directly in app
records.

## Verification

Verification is intentionally out of scope for these records. Directories and
clients can verify ownership out of band using methods such as `rel=me`,
`.well-known` resources, or other trust policies.
