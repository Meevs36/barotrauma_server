
# **MeevsBox Barotrauma Server**

## Table of Contents

1. [Introduction](#introduction)
2. [Docker Image](#docker_image)
    1. [Dependencies](#dependencies)
    2. [Quick Start](#quick_start)
    3. [Image](#image)
        1. [Build Arguments](#build_arguments)

## Introduction <a name=introduction></a>

This documentation is provided to aid in the building of the **MeevsBox Barotrauma Server**

## Docker Image <a name=docker_image></a>

### Dependencies <a name=dependencies></a>

- mbox/steamcmd

### Quick Start <a name=quick_start></a>

Provided below is a quick start guide to start a vanilla Barotrauma server.
This guide assumes that you are in the same directory as the MeevsBox Barotrauma Server Dockerfile.

``` bash
docker buildx build --tag barotrauma:latest ./;
docker run --name barotrauma_server --tty --interactive --publish 27015:27015/udp --publish 27016:27016/udp barotrauma 
```

### Image <a name=image></a>

#### Build Arguments <a name=build_arguments></a>

Provided is a 
