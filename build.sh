#!/bin/sh
# Author: Michal Svorc <michal@svorc.sk>
# Build Docker image
# Optionally pass additional arguments for Docker build command

docker build . -t michalsvorc/youtube-dl ${1}
