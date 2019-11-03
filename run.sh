#!/bin/sh
docker_image=michalsvorc/youtube-dl
download_folder=downloads
audio_format=mp3
video_format='bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'

show_help() {
    cat <<HELP
Usage: sh run.sh <COMMAND> <URL>
Helper script for using youtube-dl docker container executable $docker_image

COMMAND
  -h|--help     display this help text and exit
  audio         audio file (mp3)
  video         video file (mp4)

URL             valid URL format for youtube-dl

Example 1: ./run.sh audio https://www.youtube.com/watch?v=a1b2C3D4E5f
Example 2: ./run.sh video a1b2C3D4E5f
More info: https://github.com/ytdl-org/youtube-dl
HELP
}

die() {
    printf '\nError: %s\nSee help for proper usage:\n\n' "$1" >&2
    show_help
    exit 1
}

[[ -z "$1" ]] && die 'No COMMAND argument provided'

test_url_arg() {
    [[ -z "$1" ]] && die 'No URL argument provided'
}
create_download_folder() {
    mkdir -p "${PWD}/$download_folder"
}

download_audio() {
    test_url_arg $1
    create_download_folder
    docker run -it --rm -v "${PWD}/$download_folder:/$download_folder" $docker_image -x --audio-format $audio_format $1
}

download_video() {
    test_url_arg $1
    create_download_folder
    docker run -it --rm -v "${PWD}/$download_folder:/$download_folder" $docker_image --format $video_format $1
}

case $1 in
    -h|--help)
        show_help
        ;;
    audio)
        download_audio $2
        ;;
    video)
        download_video $2
        ;;
    *)
        die "Invalid COMMAND argument provided"
        exit 1
        ;;
esac
