FROM alpine:latest

ARG edge_repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
ARG youtube_dl_source=https://yt-dl.org/downloads/latest/youtube-dl
ARG youtube_dl_bin=/usr/local/bin/youtube-dl

RUN apk update --repository $edge_repository \
    && apk add ffmpeg --repository $edge_repository \
    && apk add python --repository $edge_repository \
    && rm -rf /var/cache/apk/* \
    && wget $youtube_dl_source -O $youtube_dl_bin \
    && chmod a+rx $youtube_dl_bin

ENTRYPOINT ["youtube-dl", "-o", "/dwn/%(title)s.%(ext)s"]