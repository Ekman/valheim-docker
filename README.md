# Valheim Docker

Run a [Valheim](https://store.steampowered.com/app/892970/Valheim/) dedicated server using Docker. There are plenty of other solutions out there that has way more features than this.
I wanted a bare minimum setup.

For more information on how to run a Valheim dedicated server, see [the official guide](https://www.valheimgame.com/support/a-guide-to-dedicated-servers/).

## Installation

The image can be found at:

```sh
docker pull ghcr.io/ekman/valheim:2
```

## Configuration

View the [example `docker-compose.yml` file](docker-compose.yml) for indications on how to install, configure and run this.

### Ports

Open UDP ports `2456-2458` on your router and forward them to the hosting server/computer.

### Volumes

Mount all these volumes to your host.

| Directory inside container | Description |
| --- | --- |
| `/home/steam/config` | Contains all save data |
| `/home/steam/game` | Contains the game files |

### Configuration

The Docker container is a wrapper on the Valheim executable. Meaning, any command line arguments that the Valheim executable supports, will the container also support. From the [the official guide](https://www.valheimgame.com/support/a-guide-to-dedicated-servers/):

| Argument | Default | Description |
|---|---|---|
| `-name "My server"` | — | Name of the server as shown in the server list. |
| `-port 2456` | 2456 | Port the server communicates on. Must match your router's port forwarding. Valheim uses this port **and** port+1 (so 2456–2457). With `-crossplay` no port forwarding is needed, but the port still distinguishes multiple servers sharing one public IP. |
| `-world "Dedicated"` | — | Creates a world with this name, or loads an existing one with a matching name. |
| `-password "Secret"` | — | Sets the server password. |
| `-savedir [PATH]` | Windows: `%USERPROFILE%/AppData/LocalLow/IronGate/Valheim`<br>Linux: `~/.config/unity3d/IronGate/Valheim` | Overrides where worlds and permission files are stored. |
| `-public 1` | 1 | Server visibility. `1` lists it in the browser; `0` hides it so players must use *Join IP* — useful for LAN servers. |
| `-logFile "d:\log.txt"` | — | Where to write the log file. |
| `-saveinterval 1800` | 1800 (30 min) | How often the world saves, in seconds. |
| `-backups 4` | 4 | How many automatic backups to keep. The first uses the short interval, the rest the long one — by default one backup 2 hours old and three spaced 12 hours apart. |
| `-backupshort 7200` | 7200 (2 h) | Interval between the first automatic backups. |
| `-backuplong 43200` | 43200 (12 h) | Interval between subsequent automatic backups. |
| `-crossplay` | off (Steam backend) | Runs on the Crossplay backend (PlayFab) so players on any platform can join. Without it, only Steam users can see and join. |
| `-instanceid "1"` | — | Unique identifier per server when hosting multiple servers on the same port from the same MAC address, so each gets its own PlayFab ID. |
| `-preset hard` | — | Sets a world modifier preset, overwriting any previous modifiers. Valid values: `Normal`, `Casual`, `Easy`, `Hard`, `Hardcore`, `Immersive`, `Hammer`. |
| `-modifier raids none` | — | Sets an individual world modifier. Place after `-preset` if both are used.<br>`Combat`: veryeasy, easy, hard, veryhard<br>`DeathPenalty`: casual, veryeasy, easy, hard, hardcore<br>`Resources`: muchless, less, more, muchmore, most<br>`Raids`: none, muchless, less, more, muchmore<br>`Portals`: casual, hard, veryhard |
| `-setkey nomap` | — | Enables a world modifier checkbox. Valid values: `nobuildcost`, `playerevents`, `passivemobs`, `nomap`. |

#### Example

You can see an example of how to run this using Docker compose [here](./docker-compose.yml).


### Updating the game files

The game files will update when the container starts. I recommend adding the following cron job to
continuously restart the server:

```sh
0 4 * * * /usr/local/bin/docker-compose --file /path/to/docker-compose.yml restart valheim >/dev/null 2>&1
```

## Versioning

This project complies with [Semantic Versioning](https://semver.org/).

## Changelog

For a complete list of changes, and how to migrate between major versions, see [releases page](https://github.com/Ekman/valheim-docker/releases).
