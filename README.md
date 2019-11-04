# youtube-dl
Executable docker container with [youtube-dl](https://github.com/ytdl-org/youtube-dl) as entry point.
- based on Alpine linux
- downloads latest youtube-dl binary in docker build
- contains [ffmpeg](https://ffmpeg.org/) for converting video files to audio-only files

## Build
Execute `build.sh` helper script.

## Run
From within cloned repository directory:
```bash
docker run -it --rm -v "<download-directory-full-path>:/opt/youtube-dl" michalsvorc/youtube-dl \
[youtube-dl-options] \
<youtube-url>
```
### Download directory
Specify full path to directory on your host system. This directory should be pre-existing and writable by non-system users, otherwise it will be created by docker with `root:root` owner, which might cause permissions error. Use `${PWD}/downloads` when running from cloned repository to use default `downloads` directory.

### Options
You can provide additional [youtube-dl options](https://github.com/ytdl-org/youtube-dl#options), with exception of `"-o, --output"` which is hard coded in docker image for proper volume binding on runtime.

#### Video format
`--format <video_format>`

#### Audio-only format
`-x --audio-format <audio_format>`

### Example
Download mp3 file format:
```bash
docker run -it --rm -v "${PWD}/downloads:/opt/youtube-dl" michalsvorc/youtube-dl \
-x --audio-format mp3 \
https://www.youtube.com/watch?v=a1b2C3D4E5f
```

## FAQ
### Best video and audio quality
youtube-dl tries to download the [best available quality](https://github.com/ytdl-org/youtube-dl#format-selection) by default.

### Certificate errors
Try to rebuild the docker image with `--no-cache` option to get the latest version of youtube-dl.

### ERROR: unable to open for writing: [Errno 13] Permission denied
Check permissions for download directory specified in `-v <download-directory-full-path>:/opt/youtube-dl`. Download directory should be writable by non-system users.