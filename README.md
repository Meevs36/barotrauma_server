
# **MeevsBox Barotrauma Server**

## Table of Contents

1. [Introduction](#introduction)
2. [Docker Image](#docker_image)
    1. [Dependencies](#dependencies)
    2. [Quick Start](#quick_start)
    3. [Image](#image)
        1. [Build Arguments](#build_arguments)
        2. [Ports](#ports)
        3. [Building](#building)
    4. [Compose](#compose)

## Introduction <a name=introduction></a>

This documentation is provided to aid in the building of the **MeevsBox Barotrauma Server**.

## Docker Image <a name=docker_image></a>

### Dependencies <a name=dependencies></a>

- steamcmd/steamcmd:debian

### Quick Start <a name=quick_start></a>

Provided below is a quick start guide to start a vanilla Barotrauma server.

``` base
docker-compose up
```

### Image <a name=image></a>

Provided is the default `.env` file which initializes some default values used for the server.
Some alternative environment files are provided in the `server_envs` directory.

#### Build Arguments <a name=build_arguments />

- `INSTALL_DIR` -- The container directory which the server will be installed to.
- `CONFIG_PKG` -- The tarball of the configuration files on the host system which will be used for the server.

#### Ports <a name=ports />

The following ports are used by the server and should be published:
- 27015/udp
- 27016/udp

#### Building <a name=building />

``` bash
docker buildx build --tag bt-base_img:latest ./;
docker create --name bt-base --tty --interactive --publish 27015:27015/udp --publish 27016:27016/udp bt-base_img
```

### Compose

Compose greatly simplifies the building and managing of the instance.
Different environment files can be specified to change the desired build.
To provide a new environment file, simply run:

To build via compose, simply run
``` base
docker-compose --env-file <file.env> up
```


