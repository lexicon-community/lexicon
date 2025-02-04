# community.lexicon.actor

Identity and profile-related lexicons for the AT Protocol.

## Examples

### community.lexicon.actor.profile

This lexicon provides extended profile information. It adds structured data for contact information, location, and links.

```json
{
  "$type": "community.lexicon.actor.profile",
  "displayName": "Downtown Coffee Co.",
  "description": "Artisanal coffee roasters and café in downtown Portland. Sourcing single-origin beans since 2015.",
  "email": "hello@downtowncoffee.com",
  "phone": {
    "number": "+15035550123"
  },
  "address": {
    "name": "Downtown Coffee Co.",
    "street": "123 SW Park Ave",
    "locality": "Portland",
    "region": "OR",
    "postalCode": "97204",
    "country": "US"
  },
  "links": [
    {
      "url": "https://downtowncoffee.com",
      "title": "Official Website",
      "description": "Visit our website for our full menu, locations, and online ordering"
    },
    {
      "url": "https://instagram.com/downtowncoffee",
      "title": "Follow us on Instagram",
      "description": "Daily coffee photos and café updates"
    }
  ],
  "createdAt": "2025-01-28T15:32:20.417Z"
}
```
