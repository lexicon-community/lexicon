# community.lexicon.preference

Lexicon schemas for user preferences on ATProtocol. These schemas allow users to declare how their public data may be used by external consumers.

## Schemas

### `community.lexicon.preference.ai`

Declares a user's preferences regarding AI usage of their public data. Decomposes AI usage into four distinct categories including training, inference, synthetic content generation, and embedding, each with independent allow/deny controls.

#### Record keys

- **`self`**: The account-wide default policy, scoped with `globalScope`.
- **TID**: Scoped overrides that target specific entities (by DID or domain) or specific collections (by NSID).

#### Preference categories

- **training**: Use of data as input for training, fine-tuning, distillation, or RLHF of ML models.
- **inference**: Use of data at inference time for retrieval, RAG, or context injection.
- **syntheticContent**: Use of data to generate synthetic content or interactions derived from user data.
- **embedding**: Use of data for vector embeddings or semantic indexing.

Each preference is tri-state: `allow: true` (permitted), `allow: false` (denied), or omitted (undefined / no declared preference).

#### Scoping

Every record declares a `scope` that determines what it applies to:

- **globalScope**: Account-wide default. Used by the record at key `self`.
- **entityScope**: Targets a specific AI consumer identified by DID or domain.
- **collectionScope**: Targets a specific NSID in the user's repository.

Overrides are additive — an override that only declares `training` inherits the global record's stance on all other categories. If the global default also omits a preference, the result is undefined and the consumer applies their own policy.

#### Consumer resolution order

1. Check for an entity-scoped override matching the consumer's DID or domain.
2. Check for a collection-scoped override matching the content's NSID.
3. Fall back to the global default at key `self`.

#### Example: global default

```json
{
  "$type": "community.lexicon.preference.ai",
  "updatedAt": "2026-04-04T12:00:00.000Z",
  "scope": {
    "$type": "#globalScope"
  },
  "preferences": {
    "training": {
      "allow": false,
      "updatedAt": "2026-04-04T12:00:00.000Z"
    },
    "inference": {
      "allow": true,
      "updatedAt": "2026-04-04T12:00:00.000Z"
    },
    "syntheticContent": {
      "allow": false,
      "updatedAt": "2026-04-04T12:00:00.000Z"
    }
  }
}
```

#### Example: entity override

```json
{
  "$type": "community.lexicon.preference.ai",
  "updatedAt": "2026-04-04T13:00:00.000Z",
  "scope": {
    "$type": "#entityScope",
    "entity": "did:plc:example-ai-company"
  },
  "preferences": {
    "training": {
      "allow": true,
      "updatedAt": "2026-04-04T13:00:00.000Z"
    }
  }
}
```

#### Example: collection override

```json
{
  "$type": "community.lexicon.preference.ai",
  "updatedAt": "2026-04-04T14:00:00.000Z",
  "scope": {
    "$type": "#collectionScope",
    "collection": "app.bsky.feed.post"
  },
  "preferences": {
    "training": {
      "allow": false,
      "updatedAt": "2026-04-04T14:00:00.000Z"
    },
    "inference": {
      "allow": false,
      "updatedAt": "2026-04-04T14:00:00.000Z"
    },
    "syntheticContent": {
      "allow": false,
      "updatedAt": "2026-04-04T14:00:00.000Z"
    },
    "embedding": {
      "allow": false,
      "updatedAt": "2026-04-04T14:00:00.000Z"
    }
  }
}
```

## Related work

- [Bluesky Proposal 0008: User Intents for Data Reuse](https://github.com/bluesky-social/proposals/blob/main/0008-user-intents/README.md)
- [IETF AI Preferences working group](https://datatracker.ietf.org/group/aipref/about/)
