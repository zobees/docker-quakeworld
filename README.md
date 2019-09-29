# quakeworld

A dockerized QuakeWorld server, which can be used either as-is or as a base for other QuakeWorld servers.

Uses some files from the [nQuake](http://nquake.com) server distribution on top of the [zobees/mvdsv](https://github.com/zobees/docker-mvdsv) image.

## Quick Start

1. Create a volume containing `id1/pak1.pak` from your original Quake distribution or place it in a directory on your docker host accessible by the Docker daemon.
2. Run the image, forwarding the appropriate ports and mounting the configuration volume or directory.

For example, using a host directory mount:

    mkdir -p /usr/local/quakeworld/id1
    cp -f path/to/id1/pak1.pak /usr/local/quakeworld/id1
    docker run -p 27500:27500 -p 27500:27500/udp \
               -v /usr/local/quakeworld:/qw-mount \
               zobees/quakeworld

## Configuring

There are three ways to configure the server:

 - A minimal amount of configuration can be supplied via environment variables.
 - You can supply volume of files that will be copied into the qw directory before the server is started.
 - You can extend the image and add/override files directly.

At the very least you need to supply your `pak1.pak` from your original Quake distribution using the volume configuration method described below.

### Configuring via environment

The following environment variables are available to configure the image:

Name (default)    | Default           | Description
----------------- | ----------------- | -----------------------------------------------------------
PORT              | 27500             | The port mvdsv should bind to (TCP and UDP)
QW_NAME           | QuakeWorld Server | The visible name of the server
QW_ADMIN          | Nobody            | The name of the server admin
QW_URL            | (none)            | The server info url
QW_GAMENAME       | qw                | The server mod to use
QW_PASSWORD       | (none)            | The password required to join the server
QW_RCON_PASSWORD  | (none)            | The server remote console password
QW_ADMIN_PASSWORD | (none)            | The server admin password
QW_MAX_CLIENTS    | 16                | The maximum number of players allowed
QW_MAX_SPECTATORS | 2                 | The maximum number of spectators allowed
QW_TIMELIMIT      | 35                | The time limit per round
QW_FRAGLIMIT      | 150               | The maximum number of frags per round
QW_MAP            | dm3               | The start map
QW_MAPLIST        | (none)            | A delimited list of maps to cycle

**NOTE: You will still need to supply `pak1.pak` via the volume configuration method below!**

### Configuring via volume

A volume is exported at `/qw-mount` which if non-empty will be recursively copied into the qw directory.  This is required to install `pak1.pak` from your original Quake distribution.

Note that you can use Go templates in your configuration files and the appropriate values will be swapped out when your configuration is copied to the qw directory.  For example `{.Env.PORT}` will be substituted with the `PORT` environment variable.

You can also completely override the default configuration should you so desire by creating a `server.cfg` in your volume.  Note that this will render all environment variable configuration ineffective unless you supply it yourself.  You can use the default configuration template [here](https://raw.githubusercontent.com/zobees/docker-quakeworld/master/build/mount/templates/qw/server.cfg) as a starting point.

### Extending the image

Just like any other Docker image, you can extend `zobees/quakeworld` in your own Dockerfile and add your own configuration as you desire.

## Developing

The [github repository](https://github.com/zobees/docker-quakeworld) for this image contains a builder image that compiles and assembles the image contents, and an associated Makefile to make things a bit easier.