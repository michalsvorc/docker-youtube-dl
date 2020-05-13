# [youtube-dl](https://github.com/ytdl-org/youtube-dl) Docker image

- based on Alpine Linux
- executable Docker image
- latest youtube-dl binary from the official source
- [ffmpeg](https://ffmpeg.org/) for converting video to audio files

## Build

Execute `build.sh` script.

## Run

youtube-dl can download 1:n URLs in a single execution.

```bash
docker run \
-it \
--rm \
--mount type=bind,source="${PWD}/downloads",target='/opt/youtube-dl' \
michalsvorc/youtube-dl \
[youtube-dl options] \
<youtube-url_1> <youtube-url_2> ... <youtube-url_n>
```

## youtube-dl options

See list of [youtube-dl options](https://github.com/ytdl-org/youtube-dl#options).
Don't add `"-o, --output"` option as it is hard-coded in Docker image for proper volume binding.

### Video format option

`--format <video_format>`

### Audio-only format option

`-x --audio-format <audio_format>`

## FAQ

### Best video and audio quality

youtube-dl tries to download the [best available quality](https://github.com/ytdl-org/youtube-dl#format-selection) by default.

### Certificate errors

Rebuild Docker image to get the latest version of youtube-dl binary.

## Troubleshooting

### ERROR: unable to open for writing: [Errno 13] Permission denied

Download directory must pre-exist on the host system and should be writable by group with id `1000`. Execute these commands in project root directory:
```bash
chown -R $(id -u):1000 "${PWD}"/downloads
chmod -R g+w "${PWD}"/downloads
```
