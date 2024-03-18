FROM --platform=linux/amd64 ghcr.io/runatlantis/atlantis:v0.17.3 as base

USER root

RUN apk --no-cache add \
    ca-certificates \
    less \
    groff \
    jq \
    curl \
    unzip \
    python3 \
    py3-pip && \
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir awscli && \
    aws --version

USER atlantis
