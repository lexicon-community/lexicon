# community.lexicon.actor

Identity and profile-related lexicons for the AT Protocol.

## Examples

### community.lexicon.actor.profile

This lexicon provides extended profile information. It adds structured data for contact information, location, and categorized links.

```json
{
  "$type": "community.lexicon.actor.profile",
  "displayName": "Downtown Coffee Co.",
  "description": "Artisanal coffee roasters and café in downtown Portland. Sourcing single-origin beans since 2015.",
  "email": "hello@downtowncoffee.com",
  "phone": "+1-503-555-0123",
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
      "type": "website",
      "url": "https://downtowncoffee.com"
    },
    {
      "type": "instagram",
      "url": "https://instagram.com/downtowncoffee"
    },
    {
      "type": "menu",
      "url": "https://downtowncoffee.com/menu",
      "title": "View Our Menu"
    }
  ],
  "createdAt": "2025-01-28T15:32:20.417Z"
}
```
