FROM alpine:latest

ARG user_name=${user_name:-youtube-dl}
ARG user_id=${user_id:-1000}
ARG group_name=${group_name:-$user_name}
ARG group_id=${group_id:-$user_id}

ARG edge_repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
ARG youtube_dl_source=https://yt-dl.org/downloads/latest/youtube-dl
ARG youtube_dl_bin=/usr/local/bin/youtube-dl

RUN apk add --no-cache --update ffmpeg \
    && apk add --no-cache --update --repository $edge_repository python \
    && wget $youtube_dl_source -O $youtube_dl_bin \
    && chmod a+rx $youtube_dl_bin

RUN addgroup \
    --gid $group_id \
    $group_name \
    && adduser \
    -u $user_id \
    --disabled-password \
    --no-create-home \
    --ingroup $group_name \
    $user_name

USER $user_name

ENTRYPOINT ["youtube-dl", "-o", "/opt/youtube-dl/%(title)s.%(ext)s"]
