# Docker youtube-dl
Alpine linux based docker image with latest version of [youtube-dl](https://github.com/ytdl-org/youtube-dl) on entrypoint. Uses [ffmpeg](https://ffmpeg.org/) for converting video files to audio-only files.

## Docker container executable
Download URL to current folder. You can provide additional [youtube-dl](https://github.com/ytdl-org/youtube-dl) options, although the `"-o, --output"` option is already specified in docker image entrypoint for proper volume binding.

Example:
```bash
$ docker run -it --rm -v "${PWD}:/dwn" michalsvorc/youtube-dl \
https://www.youtube.com/watch?v=a1b2C3D4E5f

```

## Helper script
Download URL with predefined options for video and audio-only files. 

Usage:
```bash
sh run.sh --help
```

## FAQ
### Best video and audio quality
youtube-dl tries to download the [best available quality](https://github.com/ytdl-org/youtube-dl#format-selection) by default.

### Certificate error
If you're getting certificate errors while downloading URLs, try to rebuild the docker image with `--no-cache` option to get the latest version of youtube-dl.