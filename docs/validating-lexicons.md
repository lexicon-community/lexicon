# Validating Lexicons

This document outlines several tools and techniques to validate lexicon schemas.

Creating new lexicons requires advanced technical knowledge of the AT Protocol specification and is out of scope of this document.

See also:

* https://atproto.com/specs/lexicon
* https://atproto.com/specs/nsid

## Using Client Libraries and Tooling

One practical approach to validating lexicons is to ensure that they can be built using tools and code by the libraries that will directly use them.

### @atproto

The `@atproto/lex-cli` tool can be used to generate source code used in TypeScript projects. Using it requires NodeJS, but the `validating-lexicons.Dockerfile` is provided with this document to support this method.

First, from the project root, build the container:

    $ docker build -t lexicon-community-validate -f ./docs/validating-lexicons.Dockerfile .

Then run the container with the path to the base `community` folder:

    $ docker run -v ./community/:/usr/src/app/community/ lexicon-community-validate

## Using Goat

The `goat` tool provides some validation functionality.

    $ goat lex parse ./community/lexicon/bookmarks/bookmark.json
    ./community/lexicon/bookmarks/bookmark.json: success
