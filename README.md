# docker-7d2d
Linux Dedicated Server for the Video Game 7 Days to Die using Docker

[![dst-academy GitHub](https://img.shields.io/github/release/dst-academy/docker-dontstarvetogether.svg)](https://github.com/dst-academy/docker-dontstarvetogether/releases/latest)

## Features
- [x] **serverconfig.xml** through a **ENV** variables.
- [x] **World-persistence** on container destruction.
- [ ] Configuration via **ENV** variables.
- [ ] Mods and custom **mod-configuration**.
- [ ] Automatic update of game files.
- [ ] Automatic update of mod files.

## Examples

Here is an example of a docker run line that exposes all ports and mounts the data directory to persist world and configuration files.
```
docker run -it -p '26900:26900/tcp' -p '26900-26902:26900-26902/udp' -p '8080-8082:8080-8082/tcp' -v `pwd`/data:'/data' 7d2d
```

## Attribution and Thanks
This project is heavily influenced by [DST Academy](https://github.com/dst-academy). My sincere thanks and appreciation to the authors of the [docker-dontstarvetogether](https://github.com/dst-academy/docker-dontstarvetogether) and [docker-steamcmd](https://github.com/dst-academy/docker-steamcmd).
