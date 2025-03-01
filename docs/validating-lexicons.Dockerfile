ARG NODE_VERSION=18.0.0

FROM node:${NODE_VERSION}-alpine

ENV NODE_ENV production

WORKDIR /usr/src/app

RUN --mount=type=cache,target=/root/.npm \
    npm install -g @atproto/lex-cli

CMD ["/bin/sh", "-c", "lex gen-api --yes tmp /usr/src/app/community/lexicon/*/*.json"]
