#!/bin/bash
# Author: Michal Svorc <michalsvorc.com>
# Build Docker image

# Docker build
docker build \
    --no-cache \
    --tag 'michalsvorc/youtube-dl:latest' \
    .
