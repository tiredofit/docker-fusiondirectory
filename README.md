# github.com/tiredofit/docker-fusiondirectory

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-fusiondirectory?style=flat-square)](https://github.com/tiredofit/docker-fusiondirectory/releases/latest)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-fusiondirectory/build?style=flat-square)](https://github.com/tiredofit/docker-fusiondirectory/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/fusiondirectory.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/fusiondirectory/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/fusiondirectory.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/fusiondirectory/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

* * *


## About

This will build a Docker Image for [Fusion Directory](https://www.fusiondirectory.org/) - an LDAP frontend.

## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Plugins](#plugins)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)
* Require - Access to an LDAP Server w/ necessary fusiondirectory schemas loaded. - See [openldap-fusiondirectory](https://tiredofit/openldap-fusiondirectory)
* Optional - Access to a SMTP Server


## Installation

### Build from Source
Clone this repository and build the image with `docker build <arguments> (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/fusiondirectory) and is the recommended method of installation.

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Version | Container OS | Tag       |
| ------- | ------------ | --------- |
| 1.3     | Alpine       | `:latest` |
| 1.4-dev | Alpine       | `:1.4`    |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`


## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See
the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be
modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this
image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
### Persistent Storage

If you would like to add custom HTML such as themes into Fusiondirectory map your folder that follows the `/www/fusiondirectory/html` structure into `/assets/fusiondirectory` and the script will overwrite upon bootup.

If you have custom plugins, map a folder to `/assets/plugins-custom/` and they will be automatically added to the container upon startup.

### Environment Variables
#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) or [Debian Linux](https://hub.docker.com/r/tiredofit/debian) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                         | Description                            |
| ------------------------------------------------------------- | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/)        | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)           | Nginx webserver                        |
| [PHP-FPM](https://github.com/tiredofit/docker-nginx-php-fpm/) | PHP Interpreter                        |


You can connect to multiple LDAP servers by setting the following environment variables. Simply Add as many LDAP(x) Variables for the amount of servers you wish to manage.

| Parameter          | Description                                                                                                    | Default                     |
| ------------------ | -------------------------------------------------------------------------------------------------------------- | --------------------------- |
| `LDAP1_NAME`       | The instance Name e.g. `production`                                                                            |                             |
| `LDAP1_HOST`       | Hostname with the openldap-fusiondirectory service running e.g. `openldap-fusiondirectory`                     |                             |
| `LDAP1_TLS`        | (optional) Use TLS `TRUE` or `FALSE`                                                                           | `FALSE`                     |
| `LDAP1_SSL`        | (optional) Use SSL (LDAPS) `TRUE` or `FALSE`                                                                   | `FALSE`                     |
| `LDAP1_PORT`       | (optional) Port number                                                                                         | `389` unless SSL=TRUE `636` |
| `LDAP1_ADMIN_PASS` | cn=admin,dc=example,dc=org Password e.g. `password`                                                            |                             |
| `LDAP1_ADMIN_DN`   | The Primary DN to Manage e.g. `cn=admin,dc=example,dc=org`                                                     |                             |
| `LDAP1_BASE_DN`    | The Primary Base DN to Manage e.g. `dc=example,dc=org`                                                         |                             |
| `LDAP2_NAME`       | The Instance Name (e.g. `development`)                                                                         |                             |
| `LDAP2_HOST`       | The Second Domain Hostname with the openldap-fusiondirectory service running (e.g. `openldap-fusiondirectory`) |                             |
| `LDAP2_SSL`        | Use SSL (LDAPS) `TRUE` or `FALSE`                                                                              | `false`                     |
| `LDAP2_TLS`        | (optional) Use TLS `TRUE` or `FALSE`                                                                           | `false`                     |
| `LDAP2_PORT`       | (optional) Port number                                                                                         | `389` unless TLS=TRUE `636` |
| `LDAP2_ADMIN_PASS` | cn=admin,dc=example,dc=org Password e.g. `password`                                                            |                             |
| `LDAP2_ADMIN_DN`   | The second Admin DN e.g. `cn=admin,dc=example,dc=org`                                                          |                             |
| `LDAP2_BASE_DN`    | The second BASE DN e.g. `dc=example,dc=org`                                                                    |                             |
| `LDAP_DEFAULT`     | The Default Instance to show on Login Page e.g. `production` - Default `LDAP1_NAME`                            |                             |

#### Plugins

Enable various plugins. Please see the FusionDirectory Site for configuration options. Depending on the Plugin enabled, various dependent plugins will automatically be installed. **Note you must have the schema's installed on the LDAP server otherwise you will face errors!

| Parameter                        | Description                                                              | Default     |
| -------------------------------- | ------------------------------------------------------------------------ | ----------- |
| `ENABLE_ARGONAUT`                | Enable Argonaut Server                                                   | `FALSE`     |
| `ENABLE_AUDIT_LOG_CLEANUP`       | Enable scheduled Audit Log Cleanups - Default `TRUE` if plugin enabled   |             |
| `ENABLE_USER_REMINDER`           | Enable scheduled User Reminder emails - Default `TRUE` if plugin enabled |             |
| `AUDIT_LOG_CLEANUP_CRON_EXP`     | Cron expression for when to run Audit log cleanup                        | `0 0 * * *` |
| `USER_REMINDER_CLEANUP_CRON_EXP` | Cron expression for when to send user reminder emails log cleanup        | `0 0 * * *` |
| `PLUGIN_ALIAS`                   | Mail Aliases                                                             | `FALSE`     |
| `PLUGIN_APPLICATIONS`            | Applications                                                             | `FALSE`     |
| `PLUGIN_ARCHIVE`                 | Archive Attribuites                                                      | `FALSE`     |
| `PLUGIN_ARGONAUT`                | Argonaut                                                                 | `FALSE`     |
| `PLUGIN_AUDIT`                   | Audit Trail                                                              | `FALSE`     |
| `PLUGIN_AUTOFS`                  | AutoFS                                                                   | `FALSE`     |
| `PLUGIN_AUTOFS5`                 | AutoFS5                                                                  | `FALSE`     |
| `PLUGIN_CERTIFICATES`            | Manage Certificates                                                      | `FALSE`     |
| `PLUGIN_COMMUNITY`               | Community Plugin                                                         | `FALSE`     |
| `PLUGIN_CYRUS`                   | Cyrus IMAP                                                               | `FALSE`     |
| `PLUGIN_DEBCONF`                 | Argonaut Debconf                                                         | `FALSE`     |
| `PLUGIN_DEVELOPERS`              | Developers Plugin                                                        | `FALSE`     |
| `PLUGIN_DHCP`                    | Manage DHCP                                                              | `FALSE`     |
| `PLUGIN_DNS`                     | Manage DNS                                                               | `FALSE`     |
| `PLUGIN_DOVECOT`                 | Dovecot IMAP                                                             | `FALSE`     |
| `PLUGIN_DSA`                     | System Accounts                                                          | `FALSE`     |
| `PLUGIN_DYNGROUPS`               | Dyanmic Group                                                            | `FALSE`     |
| `PLUGIN_EJBCA`                   | Unknown                                                                  | `FALSE`     |
| `PLUGIN_FAI`                     | Unknown                                                                  | `FALSE`     |
| `PLUGIN_FREERADIUS`              | FreeRadius Management                                                    | `FALSE`     |
| `PLUGIN_FUSIONINVENTORY`         | Inventory Plugin                                                         | `FALSE`     |
| `PLUGIN_GPG`                     | Manage GPG Keys                                                          | `FALSE`     |
| `PLUGIN_INVITATIONS`             | Invitations Management                                                   | `FALSE`     |
| `PLUGIN_IPAM`                    | IPAM Management                                                          | `FALSE`     |
| `PLUGIN_IPMI`                    | IPMI Management                                                          | `FALSE`     |
| `PLUGIN_KERBEROS`                | Kerberos                                                                 | `FALSE`     |
| `PLUGIN_KOPANO`                  | Kopano Core Groupware Server                                             | `FALSE`     |
| `PLUGIN_LDAPDUMP`                | LDAP Attribute Export                                                    | `FALSE`     |
| `PLUGIN_LDAPMANAGER`             | Import/Export CSV/LDIF                                                   | `FALSE`     |
| `PLUGIN_MAIL`                    | Mail Attributes                                                          | `FALSE`     |
| `PLUGIN_MAILINBLACK`             | Mail in Black                                                            | `FALSE`     |
| `PLUGIN_MIGRATION_MAILROUTING`   | Mail routing                                                             | `FALSE`     |
| `PLUGIN_MIXEDGROUPS`             | Unix/LDAP Groups                                                         | `FALSE`     |
| `PLUGIN_NAGIOS`                  | Nagios Monitoring                                                        | `FALSE`     |
| `PLUGIN_NETGROUPS`               | NIS                                                                      | `FALSE`     |
| `PLUGIN_NEXTCLOUD`               | Nextcloud Server                                                         | `FALSE`     |
| `PLUGIN_NEWSLETTER`              | Manage Newsletters                                                       | `FALSE`     |
| `PLUGIN_OPSI`                    | Inventory                                                                | `FALSE`     |
| `PLUGIN_PERSONAL`                | Personal Details                                                         | `FALSE`     |
| `PLUGIN_POSIX`                   | Posix Groups                                                             | `FALSE`     |
| `PLUGIN_POSTFIX`                 | Postfix SMTP                                                             | `FALSE`     |
| `PLUGIN_PPOLICY`                 | Password Policy                                                          | `FALSE`     |
| `PLUGIN_PUBLIC_FORMS`            | Public Forms                                                             | `FALSE`     |
| `PLUGIN_PUPPET`                  | Puppet CI                                                                | `FALSE`     |
| `PLUGIN_PUREFTPD`                | FTP Server                                                               | `FALSE`     |
| `PLUGIN_QUOTA`                   | Manage Quotas                                                            | `FALSE`     |
| `PLUGIN_RENATER_PARTAGE`         | Unknown                                                                  | `FALSE`     |
| `PLUGIN_REPOSITORY`              | Argonaut Deployment Registry                                             | `FALSE`     |
| `PLUGIN_REST`                    | REST API                                                                 | `FALSE`     |
| `PLUGIN_SAMBA`                   | File Sharing                                                             | `FALSE`     |
| `PLUGIN_SCHAC`                   | Schema for Academia                                                      | `FALSE`     |
| `PLUGIN_SEAFILE`                 | Seafile Server                                                           | `FALSE`     |
| `PLUGIN_SOGO`                    | Groupware                                                                | `FALSE`     |
| `PLUGIN_SPAMASSASSIN`            | Anti Spam                                                                | `FALSE`     |
| `PLUGIN_SQUID`                   | Proxy                                                                    | `FALSE`     |
| `PLUGIN_SSH`                     | Manage SSH Keys                                                          | `FALSE`     |
| `PLUGIN_SUBCONTRACTING`          | Unknown                                                                  | `FALSE`     |
| `PLUGIN_SUBSCRIPTIONS`           | Subscriptions                                                            | `FALSE`     |
| `PLUGIN_SUDO`                    | Manage SUDO on Hosts                                                     | `FALSE`     |
| `PLUGIN_SUPANN`                  | SUPANN                                                                   | `FALSE`     |
| `PLUGIN_SYMPA`                   | Sympa Mailing List                                                       | `FALSE`     |
| `PLUGIN_SYSTEMS`                 | Systems Management                                                       | `FALSE`     |
| `PLUGIN_USER_REMINDER`           | Password Expiry                                                          | `FALSE`     |
| `PLUGIN_WEBAUTHN`                | Authn Authorization                                                      | `FALSE`     |
| `PLUGIN_WEBLINK`                 | Display Weblink                                                          | `FALSE`     |
| `PLUGIN_ZIMBRA`                  | Zimbra                                                                   | `FALSE`     |
### Networking

The following ports are exposed.

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |


* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.## References


## References

* https://www.fusiondirectory.org/


