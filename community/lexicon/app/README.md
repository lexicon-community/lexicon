# community.lexicon.app

This set of Lexicon schemas describes apps built on or for the AT Protocol.

## Records

* `entry`: A community-submitted app listing. Any account can publish an
  entry for an app, including apps they do not own.

* `profile`: An official self-published app profile. This record should be
  published by the app's official account at rkey `self`.

## Official app profiles

Consumers may use `community.lexicon.app.entry` records for discovery, curation,
and third-party directories. When an official `community.lexicon.app.profile`
record exists, consumers should prefer that profile as the canonical app record.

An entry can point to an official profile with `officialProfileUri`, and can
name the app's official account with `officialAccountDid`.

## Verification

Verification is intentionally out of scope for these records. Directories and
clients can verify ownership out of band using methods such as `rel=me`,
`.well-known` resources, or other trust policies.
