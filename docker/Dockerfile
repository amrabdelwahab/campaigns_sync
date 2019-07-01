# Make sure to lock your ruby version to a specific one
FROM ruby:2.6.3-alpine AS dev
COPY .build-deps /
RUN cat .build-deps | xargs apk add
WORKDIR /campaign_sync
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
