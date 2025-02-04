# Web Link Lexicon

This lexicon provides a standardized way to represent web links in AT Protocol applications. It provides a simple but flexible structure for URLs with optional descriptive metadata.

## Features

- Standardized URL handling with length constraints
- Optional title and description fields
- Reusable across different contexts (profiles, posts, etc.)

## Example Usage

Basic link:
```json
{
  "url": "https://example.com"
}
```

Link with metadata:
```json
{
  "url": "https://example.com",
  "title": "Example Website",
  "description": "A comprehensive example of web linking"
}
```
