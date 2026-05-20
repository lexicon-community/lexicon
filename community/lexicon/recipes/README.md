# community.lexicon.recipes

A set of AT Protocol lexicons for sharing recipes

## Examples

### community.lexicon.recipes.recipe

```json
{
  "$type": "community.lexicon.recipes.recipe",
  "name": "Classic Chocolate Chip Cookies",
  "text": "Soft and chewy chocolate chip cookies with crispy edges and a gooey center.",
  "attribution": {
    "type": "original",
    "license": "community.lexicon.recipes.defs#licenseCreativeCommonsBy"
  },
  "ingredients": [
    "2 1/4 cups (280g) all-purpose flour",
    "1 tsp baking soda",
    "1 tsp salt",
    "1 cup (230g) unsalted butter, softened",
    "3/4 cup (150g) granulated sugar",
    "3/4 cup (165g) packed brown sugar",
    "2 large eggs",
    "2 tsp vanilla extract",
    "2 cups (340g) semi-sweet chocolate chips",
    "1 cup (170g) chopped walnuts (optional)"
  ],
  "instructions": [
    "Preheat oven to 375°F (190°C). Line baking sheets with parchment paper.",
    "In a medium bowl, whisk together flour, baking soda, and salt. Set aside.",
    "In a large bowl, cream together softened butter, granulated sugar, and brown sugar until light and fluffy (about 3 minutes).",
    "Beat in eggs one at a time, then stir in vanilla extract.",
    "Gradually mix in the dry ingredients until just combined.",
    "Fold in chocolate chips and walnuts if using.",
    "Drop rounded tablespoons of dough onto prepared baking sheets, spacing cookies about 2 inches apart.",
    "Bake for 9-11 minutes or until edges are lightly golden brown.",
    "Let cool on baking sheets for 5 minutes before transferring to wire racks to cool completely."
  ],
  "embed": {
    "images": [
      {
        "image": {
          "$type": "blob",
          "ref": {
            "$link": "abcdefg123456"
          },
          "mimeType": "image/jpeg",
          "size": 245000
        },
        "alt": "Stack of golden brown chocolate chip cookies on a wire cooling rack",
        "aspectRatio": {
          "width": 4,
          "height": 3
        }
      },
      {
        "image": {
          "$type": "blob",
          "ref": {
            "$link": "abcdefg123457"
          },
          "mimeType": "image/jpeg",
          "size": 267000
        },
        "alt": "Cross section of a chocolate chip cookie showing melted chocolate chips and soft interior",
        "aspectRatio": {
          "width": 1,
          "height": 1
        }
      }
    ]
  },
  "prepTime": "PT20M",
  "cookTime": "PT11M",
  "totalTime": "PT45M",
  "recipeYield": "24 cookies",
  "recipeCategory": "community.lexicon.recipes.defs#categoryDessert",
  "recipeCuisine": "community.lexicon.recipes.defs#cuisineAmerican",
  "cookingMethod": "community.lexicon.recipes.defs#cookingMethodBaking",
  "nutrition": {
    "calories": 150,
    "fatContent": 7.5,
    "proteinContent": 2.0,
    "carbohydrateContent": 20.0
  },
  "suitableForDiet": [
    "community.lexicon.recipes.defs#dietVegetarian"
  ],
  "keywords": [
    "cookies",
    "chocolate",
    "baking",
    "dessert",
    "snack",
    "chocolate chip",
    "classic"
  ],
  "createdAt": "2025-01-23T08:00:00.000Z",
  "updatedAt": "2025-01-23T08:00:00.000Z"
}
```

### community.lexicon.recipes.collection

```json
{
  "$type": "community.lexicon.recipes.collection",
  "name": "Annual Holiday Cookie Box",
  "text": "The assortment of cookies I bake for friends and family each December.",
  "recipes": [
    {
      "uri": "at://did:plc:1234/community.lexicon.recipes.recipe/01JEVQRA9MCR23263PARX101PE",
      "cid": "01JEVQRA9MCR23263PARX101PE"
    },
    {
      "uri": "at://did:plc:1234/community.lexicon.recipes.recipe/01JEVTAXQ4A79X03CBTE1NTTQZ",
      "cid": "01JEVTAXQ4A79X03CBTE1NTTQZ"
    }
  ],
  "createdAt": "2024-12-18T18:02:30Z",
  "updatedAt": "2024-12-18T18:02:30Z"
}
```
