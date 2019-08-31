#!/bin/sh
docker_image=michalsvorc/youtube-dl
download_folder=dwn

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

[[ $# -eq 0 ]] && die 'No arguments provided'
[[ -z "$2" ]] && die 'No URL argument provided'

create_download_folder () {
    mkdir -p "${PWD}/$download_folder"
}

download_audio () {
    docker run -it --rm -v "${PWD}/$download_folder:/$download_folder" $docker_image -x --audio-format mp3 $1
}

download_video () {
    docker run -it --rm -v "${PWD}/$download_folder:/$download_folder" $docker_image $1
}

case $1 in
    -h|--help)
        show_help
        ;;
    audio)
        create_download_folder
        download_audio $2
        ;;
    video)
        create_download_folder
        download_video $2
        ;;
    *)
        die "Invalid COMMAND argument provided"
        exit 1
        ;;
esac