# Valheim Docker

Run a Valheim dedicated server using Docker. There are plenty of other solutions out there that has way more features than this. However,
I wanted a bare minimum setup that does not contain any fuss.

## Installation

View the [example `docker-compose.yml` file](docker-compose.yml) for indications on how to install and run this.

## Configuration

Detailed explanation on how to configure your Valheim server.

### Volumes

The following interesting volumes/mount points exists:

* `/home/steam/config` - Contain all save data
* `/home/steam/game` - Contains the game files

Mount them both.

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

The game files will update when starting the container. I recommend adding the following cron job to
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


