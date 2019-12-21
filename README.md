# tiredofit/fusiondirectory

[![Build Status](https://img.shields.io/docker/build/tiredofit/fusiondirectory.svg)](https://hub.docker.com/r/tiredofit/fusiondirectory)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/fusiondirectory.svg)](https://hub.docker.com/r/tiredofit/fusiondirectory)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/fusiondirectory.svg)](https://hub.docker.com/r/tiredofit/fusiondirectory)
[![Docker 
Layers](https://images.microbadger.com/badges/image/tiredofit/fusiondirectory.svg)](https://microbadger.com/images/tiredofit/fusiondirectory)


# Introduction

This will build a container for [Fusion Directory](https://www.fusiondirectory.org/) a Directory Manager frontend for LDAP.

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, nano, vim) for easier management. It also supports sending to external SMTP servers

Additional Components Inside are Nginx, PHP7.2 w/ APC, OPCache, LDAP extensions and Openldap clients.


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit)

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

Make sure you have installed the appropriate schemas on the LDAP Server.


# Configuration

### Persistent Storage

If you would like to add custom HTML such as themes into Fusiondirectory map your folder that follows the /www/fusiondirectory/html structure into /assets/fusiondirectory and the script will overwrite upon bootup.

If you have custom plugins, map a folder to /assets/plugins-custom/ and they will be automatically added to the container upon startup.


### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), and the [Nginx+PHP-FPM Engine](https://hub.docker.com/r/tiredofit/nginx-php-fpm) below is the complete list of available options that can be used to customize your installation.

You can connect to multiple LDAP servers by setting the following environment variables. Simply Add as many LDAP(x) Variables for the amount of servers you wish to manage.

| Parameter | Description |
|-----------|-------------|
| `LDAP1_NAME` | The instance Name e.g. `production` |
| `LDAP1_HOST` | Hostname with the openldap-fusiondirectory service running e.g. `openldap-fusiondirectory` |
| `LDAP1_TLS` | (optional) Use TLS `TRUE` or `FALSE` - Default `false` |
| `LDAP1_PORT` | (optional) Port number - Default `389` unless TLS=TRUE `636`
| `LDAP1_ADMIN_PASS` | cn=admin,dc=example,dc=org Password e.g. `password` |
| `LDAP1_ADMIN_DN` | The Primary DN to Manage e.g. `cn=admin,dc=example,dc=org` |
| `LDAP1_BASE_DN` | The Primary Base DN to Manage e.g. `dc=example,dc=org` |
| `LDAP2_NAME` | The Instance Name (e.g. `development`) |
| `LDAP2_HOST` | The Second Domain Hostname with the openldap-fusiondirectory service running (e.g. `openldap-fusiondirectory`) |
| `LDAP2_TLS` | (optional) Use TLS `TRUE` or `FALSE` - Default `false` |
| `LDAP2_PORT` | (optional) Port number - Default `389` unless TLS=TRUE `636`
| `LDAP2_ADMIN_PASS` | cn=admin,dc=example,dc=org Password e.g. `password` |
| `LDAP2_ADMIN_DN` | The second Admin DN e.g. `cn=admin,dc=example,dc=org` |
| `LDAP2_BASE_DN` | The second BASE DN e.g. `dc=example,dc=org` |
| `LDAP_DEFAULT` | The Default Instance to show on Login Page e.g. `production` - Default `LDAP1_NAME` |

#### Plugins 

Enable various plugins. Please see the FusionDirectory Site for configuration options. Depending on the Plugin enabled, various dependent plugins will automatically be installed. **Note you must have the schema's installed on the LDAP server otherwise you will face errors!

| Parameter | Description |
|-----------|-------------|
| `ENABLE_ARGONAUT` | Enable Argonaut Server - Default: `FALSE` |
| `ENABLE_AUDIT_LOG_CLEANUP` | Enable scheduled Audit Log Cleanups - Default `TRUE` if plugin enabled |
| `ENABLE_USER_REMINDER` | Enable scheduled User Reminder emails - Default `TRUE` if plugin enabled |
| `AUDIT_LOG_CLEANUP_CRON_EXP` | Cron expression for when to run Audit log cleanup - Default `0 0 * * *` |
| `USER_REMINDER_CLEANUP_CRON_EXP` | Cron expression for when to send user reminder emails log cleanup - Default `0 0 * * *` |
| `PLUGIN_ALIAS` | Mail Aliases - Default: `FALSE` |
| `PLUGIN_APPLICATIONS` | Applications - Default: `FALSE` |
| `PLUGIN_ARGONAUT` | Argonaut - Default: `FALSE` |
| `PLUGIN_AUDIT` |  Audit Trail - Default: `FALSE` |
| `PLUGIN_AUTOFS` |  AutoFS - Default: `FALSE` |
| `PLUGIN_CERTIFICATES` | Manage Certificates - Default: `FALSE` |
| `PLUGIN_COMMUNITY` | Community Plugin - Default: `FALSE` |
| `PLUGIN_CYRUS` | Cyrus IMAP - Default: `FALSE` |
| `PLUGIN_DEBCONF` | Argonaut Debconf - Default: `FALSE` |
| `PLUGIN_DEVELOPERS` | Developers Plugin - Default: `FALSE` |
| `PLUGIN_DHCP` | Manage DHCP - Default: `FALSE` |
| `PLUGIN_DNS` | Manage DNS - Default: `FALSE` |
| `PLUGIN_DOVECOT` | Dovecot IMAP - Default: `FALSE` |
| `PLUGIN_DSA` | System Accounts - Default: `FALSE` |
| `PLUGIN_EJBCA` | Unknown - Default: `FALSE` |
| `PLUGIN_FAI` | Unknown - Default: `FALSE` |
| `PLUGIN_FREERADIUS` | FreeRadius Management - Default: `FALSE` |
| `PLUGIN_FUSIONINVENTORY` | Inventory Plugin - Default: `FALSE` |
| `PLUGIN_GPG` | Manage GPG Keys - Default: `FALSE` |
| `PLUGIN_IPMI` | IPMI Management - Default: `FALSE` |
| `PLUGIN_LDAPDUMP` | LDAP Attribute Export - Default: `FALSE` |
| `PLUGIN_LDAPMANAGER` | Import/Export CSV/LDIF - Default: `FALSE` |
| `PLUGIN_MAIL` | Mail Attributes - Default: `FALSE` |
| `PLUGIN_MIXEDGROUPS` | Unix/LDAP Groups - Default: `FALSE` |
| `PLUGIN_NAGIOS` | Nagios Monitoring - Default: `FALSE` |
| `PLUGIN_NETGROUPS` | NIS - Default: `FALSE` |
| `PLUGIN_NEWSLETTER` | Manage Newsletters - Default: `FALSE` |
| `PLUGIN_OPSI` | Inventory - Default: `FALSE` |
| `PLUGIN_PERSONAL` | Personal Details - Default: `FALSE` |
| `PLUGIN_POSIX` | Posix Groups - Default: `FALSE` |
| `PLUGIN_POSTFIX` | Postfix SMTP - Default: `FALSE` |
| `PLUGIN_PPOLICY` | Password Policy - Default: `FALSE` |
| `PLUGIN_PUPPET` | Puppet CI - Default: `FALSE` |
| `PLUGIN_PUREFTPD` | FTP Server - Default: `FALSE` |
| `PLUGIN_QUOTA` | Manage Quotas - Default: `FALSE` |
| `PLUGIN_RENATER_PARTAGE` | Unknown - Default: `FALSE` |
| `PLUGIN_REPOSITORY` | Argonaut Deployment Registry - Default: `FALSE` |
| `PLUGIN_SAMBA` | File Sharing - Default: `FALSE` |
| `PLUGIN_SOGO` | Groupware - Default: `FALSE` |
| `PLUGIN_SPAMASSASSIN` | Anti Spam - Default: `FALSE` |
| `PLUGIN_SQUID` | Proxy - Default: `FALSE` |
| `PLUGIN_SSH` | Manage SSH Keys - Default: `FALSE` |
| `PLUGIN_SUBCONTRACTING` | Unknown  - Default: `FALSE` |
| `PLUGIN_SUDO` |  Manage SUDO on Hosts - Default: `FALSE` |
| `PLUGIN_SUPANN` |  SUPANN - Default: `FALSE` |
| `PLUGIN_SYMPA` |  Sympa Mailing List - Default: `FALSE` |
| `PLUGIN_SYSTEMS` |  Systems Management - Default: `FALSE` |
| `PLUGIN_USER_REMINDER` |  Password Expiry - Default: `FALSE` |
| `PLUGIN_WEBLINK` | Display Weblink - Default: `FALSE` |

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


