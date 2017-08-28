# tiredofit/fusiondirectory

# Introduction

This will build a container for [Fusion Directory](https://www.fusiondirectory.org/) a Directory Manager frontend for LDAP.

**Currently Not Functioning Correctly**
This Container uses Alpine:3.6 as a base.
Additional Components Inside are Nginx, PHP7 w/ APC, OPCache, LDAP extensions


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit) [https://git.example.org/daveconroy]

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Database](#database)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

You must have use the accompanying [openldap-fusiondirectory](https://tiredofit/openldap-fusiondirectory) image with matching version number for the correct schema to operate!


# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/fusiondirectory) and is the 
recommended method of installation.


```bash
docker pull tiredofit/fusiondirectory
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

> **NOTE**: If you want to use a note here use it.

# Configuration

### Persistent Storage

If you would like to add custom HTML such as themes into Fusiondirectory map your folder that follows the /usr/share/fusiondirectory structure into /assets/fusiondirectory and the script will overwrite upon bootup.


### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), and the [Nginx+PHP-FPM Engine](https://hub.docker.com/r/tiredofit/nginx-php-fpm) below is the complete list of available options that can be used to customize your installation.

| Parameter | Description |
|-----------|-------------|
| `LDAP_DOMAIN` | The Domain to Manage (e.g. `example.org`) |
| `LDAP_HOST` | Hostname with the openldap-fusiondirectory service running (e.g. `openldap-fusiondirectory`) |
| `LDAP_ADMIN_PASSWORD` | cn=admin,dc=org,dc=org Password (e.g. `password`) |

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `80` | HTTP |


# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. fusiondirectory) bash
```

# References

* https://www.fusiondirectory.org/

