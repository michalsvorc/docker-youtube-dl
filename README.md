# [youtube-dl](https://github.com/ytdl-org/youtube-dl) Docker image
- based on Alpine Linux
- executable Docker container
- downloads latest youtube-dl binary from the official source
- contains [ffmpeg](https://ffmpeg.org/) for converting video files to audio-only files

## Build
Execute `build.sh` script in project root directory. Optionally pass additional arguments for Docker [build command](https://docs.docker.com/engine/reference/commandline/build/). To supply multiple arguments or arguments with spaces, pass them surrounded by `''`. 
Example: `./build.sh '--arg1 --arg2 key=val'`

### Download directory
Download directory should pre-exist on host system and be writable by group with `gid=1000` by default. This can be changed by passing `'--build-arg group_id=<N>'` to `build.sh` script.

### youtube-dl options
Provide additional [youtube-dl options](https://github.com/ytdl-org/youtube-dl#options), with exception of `"-o, --output"` which is hard coded in Docker image for proper volume binding on runtime.

#### Video format option
`--format <video_format>`

#### Audio-only format option
`-x --audio-format <audio_format>`

## Run
youtube-dl can download 1:n URLs in single execution.
```bash
docker run -it --rm -v "<host-download-directory-full-path>:/opt/youtube-dl" michalsvorc/youtube-dl \
[youtube-dl-options] \
<youtube-url-1 youtube-url-2 ... youtube-url-n>
```

### Run example
Use `${PWD}/downloads` when running from project root directory to use default `./downloads` directory.
```bash
docker run -it --rm -v "${PWD}/downloads:/opt/youtube-dl" michalsvorc/youtube-dl \
-x --audio-format mp3 \
https://www.youtube.com/watch?v=a1b2C3D4E5f https://www.youtube.com/watch?v=1B2c3d4e5F6
```

## FAQ

### Best video and audio quality
youtube-dl tries to download the [best available quality](https://github.com/ytdl-org/youtube-dl#format-selection) by default.

### Certificate errors
Rebuild Docker image with `./build.sh '--no-cache'` option to get latest version of youtube-dl binary.

### ERROR: unable to open for writing: [Errno 13] Permission denied
Check permissions for host download directory specified in `-v <host-download-directory-full-path>:/opt/youtube-dl`. 
Run `chown $(id -u):1000 <download-directory>`, then `chmod g+w -R <download-directory>` to make the directory writable by group with `gid=1000`.