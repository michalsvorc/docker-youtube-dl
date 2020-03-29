FROM alpine:3

# Build arguments
ARG user_name=user
ARG user_id=1000
ARG group_name=mount
ARG group_id=1000
ARG edge_repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
ARG youtube_dl_repository=https://yt-dl.org/downloads/latest/youtube-dl
ARG youtube_dl_binary_path=/usr/local/bin/youtube-dl

# Update package repositories and install packages
RUN apk add \
    --no-cache \
    --update \
    ffmpeg \
    && apk add \
    --no-cache \
    --update \
    --repository $edge_repository \
    python

# Download youtube-dl binary
RUN wget $youtube_dl_repository -O $youtube_dl_binary_path \
    && chmod a+rx $youtube_dl_binary_path

# Create non-system user
RUN addgroup \
    --gid $group_id \
    $group_name \
    && adduser \
    --uid $user_id \
    --disabled-password \
    --ingroup $group_name \
    $user_name

# Use non-system user
USER $user_name

# Runtime entrypoint
ENTRYPOINT ["youtube-dl", "-o", "/opt/youtube-dl/%(title)s.%(ext)s"]
