FROM alpine:latest

ARG edge_repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
ARG youtube_dl_source=https://yt-dl.org/downloads/latest/youtube-dl
ARG youtube_dl_bin=/usr/local/bin/youtube-dl
ARG username=youtube-dl

RUN apk add --no-cache --update ffmpeg \
    && apk add --no-cache --update --repository $edge_repository python \
    && wget $youtube_dl_source -O $youtube_dl_bin \
    && chmod a+rx $youtube_dl_bin \
    && adduser -D -H -u 1000 $username

USER $username

ENTRYPOINT ["youtube-dl", "-o", "/opt/youtube-dl/%(title)s.%(ext)s"]
