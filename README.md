# tiredofit/openldap-fusiondirectory

[![Build 
Status](https://img.shields.io/docker/build/tiredofit/openldap-fusiondirectory.svg)](https://hub.docker.com/r/tiredofit/openldap-fusiondirectory)
[![Docker 
Pulls](https://img.shields.io/docker/pulls/tiredofit/openldap-fusiondirectory.svg)](https://hub.docker.com/r/tiredofit/openldap-fusiondirectory)
[![Docker 
Stars](https://img.shields.io/docker/stars/tiredofit/openldap-fusiondirectory.svg)](https://hub.docker.com/r/tiredofit/openldap-fusiondirectory)
[![Docker 
Layers](https://images.microbadger.com/badges/image/tiredofit/openldap-fusiondirectory.svg)](https://microbadger.com/images/tiredofit/openldap-fusiondirectory)

# Introduction

Dockerfile to build a [OpenLDAP Server](https://sourceforge.net/projects/openldap-fusiondirectory/) with [Fusion 
Directory](https://www.fusiondirectory.org) Schema's Included.
It includes all the functions in the [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) such as Multi-Master Replication, 
TLS, and other features.

This Container uses [tiredofit/openldap](https://github.com/tiredofit/docker-openldap) as a base.


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](daveconroy@tiredofit.ca)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](Changelog.md)
- [Prerequisites](#prerequisites)
- [Dependencies](#dependendcies)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Database](#database)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
- [References](#references)



# Dependencies

To build this image you must have the [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) built and available. To utilize, 
you must also have the [Fusion Directory Image](https://github.com/tiredofit/docker-fusiondirectory) image built and available.

# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/r/tiredofit/openldap-fusiondirectory) and is the 
recommended method of installation.


```bash
docker pull tiredofit/openldap-fusiondirectory
```


# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working 
[docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Map [Network Ports](#networking) to allow external access.

Start openldap-fusiondirectory using:

```bash
docker-compose up
```
__NOTE__: Please allow up to 1 minutes for the application to start.


## Data-Volumes

* Please see [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) for Data Volume Configuration.

There is an additional data volume exposed:

| Directory | Description |
|-----------|-------------|
| `/assets/fusiondirectory-custom/` | Place Schema files here to be imported into FusionDirectory |

## Environment Variables

* Please see [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) for Environment Variables Configuration
* There are specific environment variables to this image:


| Variable | Description |
|-----------|-------------|
| `FUSIONDIRECTORY_ADMIN_USER` | Default FD Admin User - Default `fd-admin` |
| `FUSIONDIRECTORY_ADMIN_PASS` | Default FD Admin Password - Default `admin` |
| `ORGANIZATION` | Organization Name Default: `Example Organization`

## Schema Installation
Depending on your choices, the following schemas are available for installation. You must have these also enabled on the 
FusionDirectory application image to make use of it. If you would like to reapply the schemas set `REAPPLY_PLUGIN_SCHEMAS` to `TRUE`.

| Variable | Description |
|-----------|-------------|
| `REAPPLY_PLUGIN_SCHEMAS` | Reapply Plugin Schemas `TRUE` or `FALSE` - Default: `FALSE` |
| `PLUGIN_ALIAS` | Mail Aliases - Default: `FALSE` |
| `PLUGIN_APPLICATIONS` | Applications - Default: `FALSE` |
| `PLUGIN_ARGONAUT` | Argonaut - Default: `FALSE` |
| `PLUGIN_AUDIT` |  Audit Trail - Default: `TRUE` |
| `PLUGIN_AUTOFS` |  AutoFS - Default: `FALSE` |
| `PLUGIN_CERTIFICATES` | Manage Certificates - Default: `FALSE` |
| `PLUGIN_COMMUNITY` | Community Plugin - Default: `FALSE` |
| `PLUGIN_CYRUS` | Cyrus IMAP - Default: `FALSE` |
| `PLUGIN_DEBCONF` | Argonaut Debconf - Default: `FALSE` |
| `PLUGIN_DEVELOPERS` | Developers Plugin - Default: `FALSE` |
| `PLUGIN_DHCP` | Manage DHCP - Default: `FALSE` |
| `PLUGIN_DNS` | Manage DNS - Default: `FALSE` |
| `PLUGIN_DOVECOT` | Dovecot IMAP - Default: `FALSE` |
| `PLUGIN_DSA` | System Accounts - Default: `TRUE` |
| `PLUGIN_EJBCA` | Unknown - Default: `FALSE` |
| `PLUGIN_FAI` | Unknown - Default: `FALSE` |
| `PLUGIN_FREERADIUS` | FreeRadius Management - Default: `FALSE` |
| `PLUGIN_FUSIONINVENTORY` | Inventory Plugin - Default: `FALSE` |
| `PLUGIN_GPG` | Manage GPG Keys - Default: `FALSE` |
| `PLUGIN_IPMI` | IPMI Management - Default: `FALSE` |
| `PLUGIN_MAIL` | Mail Attributes - Default: `TRUE` |
| `PLUGIN_MIXEDGROUPS` | Unix/LDAP Groups - Default: `FALSE` |
| `PLUGIN_NAGIOS` | Nagios Monitoring - Default: `FALSE` |
| `PLUGIN_NETGROUPS` | NIS - Default: `FALSE` |
| `PLUGIN_NEWSLETTER` | Manage Newsletters - Default: `FALSE` |
| `PLUGIN_OPSI` | Inventory - Default: `FALSE` |
| `PLUGIN_PERSONAL` | Personal Details - Default: `TRUE` |
| `PLUGIN_POSIX` | Posix Groups - Default: `FALSE` |
| `PLUGIN_POSTFIX` | Postfix SMTP - Default: `FALSE` |
| `PLUGIN_PPOLICY` | Password Policy - Default: `TRUE` |
| `PLUGIN_PUPPET` | Puppet CI - Default: `FALSE` |
| `PLUGIN_PUREFTPD` | FTP Server - Default: `FALSE` |
| `PLUGIN_QUOTA` | Manage Quotas - Default: `FALSE` |
| `PLUGIN_RENATER_PARTAGE` | Unknown - Default: `FALSE` |
| `PLUGIN_REPOSITORY` | Argonaut Deployment Registry - Default: `FALSE` |
| `PLUGIN_SAMBA` | File Sharing - Default: `FALSE` |
| `PLUGIN_SOGO` | Groupware - Default: `FALSE` |
| `PLUGIN_SPAMASSASSIN` | Anti Spam - Default: `FALSE` |
| `PLUGIN_SQUID` | Proxy - Default: `FALSE` |
| `PLUGIN_SSH` | Manage SSH Keys - Default: `TRUE` |
| `PLUGIN_SUBCONTRACTING` | Unknown  - Default: `FALSE` |
| `PLUGIN_SUDO` |  Manage SUDO on Hosts - Default: `FALSE` |
| `PLUGIN_SUPANN` |  SUPANN - Default: `FALSE` |
| `PLUGIN_SYMPA` |  Sympa Mailing List - Default: `FALSE` |
| `PLUGIN_SYSTEMS` |  Systems Management - Default: `TRUE` |
| `PLUGIN_USER_REMINDER` |  Password Expiry - Default: `FALSE` |
| `PLUGIN_WEBLINK` | Display Weblink - Default: `FALSE` |


## Networking

* Please see [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) for Networking Configuration


## Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it openldap-fusiondirectory bash
```

# References

* https://fusiondirectory.org
* https://openldap.org


