{
  "lexicon": 1,
  "id": "app.bsky.actor.profile",
  "defs": {
    "main": {
      "type": "record",
      "description": "A declaration of a Bluesky account profile.",
      "key": "self",
      "record": {
        "type": "object",
        "properties": {
          "displayName": { "type": "string", "maxLength": 640 },
          "description": { "type": "string", "maxLength": 2560 },
          "avatar": { "type": "blob", "accept": ["image/*"], "maxSize": 1000000 },
          "banner": { "type": "blob", "accept": ["image/*"], "maxSize": 1000000 },
          "labels": { "type": "union", "refs": ["com.atproto.label.defs#selfLabels"] },
          "createdAt": { "type": "string", "format": "datetime" }
        }
      }
    }
  }
}
