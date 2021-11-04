# Valheim Docker

Run a Valheim dedicated server using Docker. There are plenty of other solutions out there that has way more features than this.
I wanted a bare minimum setup.

## Installation

The image can be found at:

```sh
docker pull ghcr.io/ekman/valheim:1
```

## Configuration

View the [example `docker-compose.yml` file](docker-compose.yml) for indications on how to install, configure and run this.

### Ports

Open UDP ports 2456, 2457 and 2458 on your router and forward them to the hosting server/computer.

### Volumes

Mount all these volumes to your host.

| Directory inside container | Description |
| --- | --- |
| `/home/steam/config` | Contains all save data |
| `/home/steam/game` | Contains the game files |

### Environment variables

See below for an explanation of environment variables.

| Name | Description |
| --- | --- |
| NAME | Name appears in the server browser |
| WORLD | The save files will be named after this |
| PORT | Open these ports in your router. Recommended leaving as default. |
| PASSWORD | Users must enter this password to enter your server |
| PUBLIC | Should be `1` or `0`. If `1` then the server will appear in the server browser |


### Updating the game files

The game files will update when the container starts. I recommend adding the following cron job to
continuously restart the server:

```sh
0 4 * * * docker-compose --file /path/to/docker-compose.yml restart valheim
```

## Versioning

This project only uses the `MAJOR` version part of [Semantic Versioning](https://semver.org/).

## Changelog

For a complete list of changes, and how to migrate between major versions, see [releases page](https://github.com/Ekman/valheim-docker/releases).

## Useful links:

Here are some useful links:

* [Valheim fandom](https://valheim.fandom.com/wiki/Hosting_Servers)


