FROM alpine:latest

ARG edge_repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
ARG youtube_dl_source=https://yt-dl.org/downloads/latest/youtube-dl
ARG youtube_dl_bin=/usr/local/bin/youtube-dl
ARG username=youtube-dl

RUN apk update --repository $edge_repository \
    && apk add ffmpeg \
    && apk add python --repository $edge_repository \
    && rm -rf /var/cache/apk/* \
    && wget $youtube_dl_source -O $youtube_dl_bin \
    && chmod a+rx $youtube_dl_bin \
    && adduser -D -u 1000 $username

USER ${username}

ENTRYPOINT ["youtube-dl", "-o", "/opt/youtube-dl/%(title)s.%(ext)s"]
