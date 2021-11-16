## 2.7.14 2021-11-16 <dave at tiredofit dot ca>

   ### Changed
      - Additional Fix for REST Nginx configuration


## 2.7.13 2021-11-10 <dave at tiredofit dot ca>

   ### Changed
      - Fix for 2.7.12


## 2.7.12 2021-11-10 <dave at tiredofit dot ca>

   ### Changed
      - Fix for when containers weren't compltely stopped and REST plugins enabled


## 2.7.11 2021-10-16 <dave at tiredofit dot ca>

   ### Added
      - Add MailinBlack plugin


## 2.7.10 2021-08-26 <bmalynovytch@github>

   ### Fixed
      - Parsing of Multiple LDAP Hosts under Kubernetes not working correctly


## 2.7.9 2021-07-21 <dave at tiredofit dot ca>

   ### Changed
      - Change the way Cron is handled


## 2.7.8 2021-05-25 <dave at tiredofit dot ca>

   ### Changed
      - Changes to nginx configuration


## 2.7.7 2021-05-25 <dave at tiredofit dot ca>

   ### Changed
      - Fix for 2.7.6


## 2.7.6 2021-05-25 <dave at tiredofit dot ca>

   ### Added
      - Add customizable rest prefix (/rest/)
      - Seperate REST/Webservice logging (rest-error.log rest-access.log)
      - Add /logout/ alias

   ### Changed
      - Fix nginx configuration to allow arguments after /rest.php


## 2.7.5 2021-05-14 <dave at tiredofit dot ca>

   ### Added
      - Add /assets/custom-scripts execution support


## 2.7.4 2021-05-13 <dave at tiredofit dot ca>

   ### Changed
      - Remove Subscription Notification by variable


## 2.7.3 2021-05-13 <dave at tiredofit dot ca>

   ### Changed
      - Fix for ALIAS plugin


## 2.7.2 2021-05-12 <dave at tiredofit dot ca>

   ### Changed
      - Change for /assets/plugins to /assets/custom-plugins


## 2.7.1 2021-05-11 <dave at tiredofit dot ca>

   ### Added
      - Add perl-io-text as run dependency as it was failing building from CPAN as part of another package


## 2.7.0 2021-05-10 <dave at tiredofit dot ca>

   ### Added
      - FusionDirectory 1.4dev
      - Smarty 3.1.39
      - SmartyGettext 1.6.2
      - PHP 7.4
      - Prototype 1.7.3


## 2.6.2 2020-11-05 <dave at tiredofit dot ca>

   ### Changed
      - Add symlink from /etc/openldap to /etc/ldap to match hardcoded fusiondirectory location defaults


## 2.6.1 2020-11-04 <dave at tiredofit dot ca>

   ### Changed
      - Switch to pulling sourcecode from repo.fusiondirectory.org as opposed to via git


## 2.6.0 2020-11-03 <dave at tiredofit dot ca>

   ### Added
      - Add StartTLS support for connecting to OpenLDAP Servers

   ### Changed
      - Renamed LDAP1_TLS to LDAP1_SSL to properly describe what the variable does


## 2.5.2 2020-06-26 <dave at tiredofit dot ca>

   ### Changed
      - Place Nextcloud main.inc file in alternate location for installation


## 2.5.1 2020-06-23 <dave at tiredofit dot ca>

   ### Changed
      - Fix Nextcloud package whichis broken upstream


## 2.5.0 2020-06-20 <dave at tiredofit dot ca>

   ### Added
      - Add Kopano Plugin
      - Add Nextcloud Plugin
      - Add Seafile Plugin


## 2.4.1 2020-06-16 <dave at tiredofit dot ca>

   ### Added
      - Add another way of utilizing custom plugins (/assets/custom-plugins/)


## 2.4.0 2020-06-09 <dave at tiredofit dot ca>

   ### Added
      - Changes to Support new tiredofit/alpine 5.0.0 base image


## 2.3.3 2020-04-21 <dave at tiredofit dot ca>

   ### Changed
      - Fix missing redirection code when using TLS for argonaut


## 2.3.2 2020-04-21 <dave at tiredofit dot ca>

   ### Changed
      - Fix error in spacing when setting `set -a`


## 2.3.1 2020-04-20 <dave at tiredofit dot ca>

   ### Changed
      - Remove console output of environment variables

## 2.3.0 2020-04-17 <dave at tiredofit dot ca>

   ### Changed
      - More fixes to ENABLE_ARGONAUT conditions
      - Minor console logging fix
      - Properly Define LDAP Port if TLS is used
      - Update image to support new tiredofit/alpine:4.5.1 base


## 2.2.5 2020-04-16 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Dockerfile not being able to extract Fusiondirectory introduced in version 2.2.4


## 2.2.4 2020-04-16 <dave at tiredofit dot ca>

   ### Changed
      - Split argonaut service from Fusiondirectory init script
      - Cleanup of Dockerfile to remove old comments and perform cleanup steps last

## 2.2.3 2020-03-26 <dave at tiredofit dot ca>

   ### Added
      - Add POE::Component::Server::JSONRPC::Http Module to resolve argonaut errors


## 2.2.2 2020-03-04 <dave at tiredofit dot ca>

   ### Added
      - Update image to support new tiredofit/alpine:4.4.0 base


## 2.2.1 2020-02-24 <talltechdude@github>

   ### Changed
      - Fix Mutleiple LDAP Hosts Regex
      - Allow spaces in environment variables

## 2.2.0 2020-01-14 <sagreal@github>

   ### Added
      - Add Secrets Support
      - Add Sinaps Plugin


## 2.1.0 2020-01-02 <dave at tiredofit dot ca>

   ### Added
      - Updates to support new tiredofit/alpine base image

## 2.0.1 2019-12-23 <dave at tiredofit dot ca>

   ### Changed
      - Fix spelling mistakes limiting plugins from being enabled


## 2.0.0 2019-12-23 <dave at tiredofit dot ca>

   ### Added
      - Refactor Image to utilize new tiredofit/nginx and tiredofit/nginx-php-fpm images
      - Code Cleanup, better verbosity
      - Removed extra crontab entries


## 1.19.1 2019-11-27 <dave at tiredofit dot ca>

   ### Changed
      - Update startup script to properly enable User Reminder Plugin (credit hongkongkiwi@github)


## 1.19 2019-10-23 <jrevillard@github>

* Fix for crontab expressions for argonaut (User Reminder/Audit) functions
* Tweak for password recovery emails to properly send the URL.

## 1.18 2019-10-22 <jrevillard@github>

* Fix for User Reminder Script (Argonaut)
* Added perl-mime-tools

## 1.17.1 2019-06-19 <dave at tiredofit dot ca>

* Fix Issue with TLS / LDAPS not writing configuration correctly - Credit for find <dcendents@github>

## 1.16 2019-05-06 <dave at tiredofit dot ca>

* Update to FusionDirectory 1.3

## 1.15 2019-03-14 <dave at tiredofit dot ca>

* Remove duplicate container init script 

## 1.14 2019-03-12 <credit to michalekj at github>

* Fix URLs for 1.3 backported fix
* Fix ADMIN_DN Entry for Multiple LDAP servers
* Update docker-compose to pull from :latest instead of old :alpine

## 1.13 2018-12-27 <dave at tiredofit dot ca>

* Update to FusionDirectory 1.2.3

## 1.12 2018-09-17 <dave at tiredofit dot ca>

* Update to FusionDirectory 1.2.2
* Switch to FusionDirectory Gitlab
* Argonaut 1.2.1

## 1.11 2018-07-23 <dave at tiredofit dot ca>

* Enable scheduled User Reminder Option for password expiry

## 1.10 2018-07-22 <dave at tiredofit dot ca>

* Rework the Multiple Hosts Option

## 1.9 2018-07-21 <dave at tiredofit dot ca>

* Switch to PHP-FPM 7.2 / Alpine 3.8

## 1.82 2018-07-21 <dave at tiredofit dot ca>

* Allowed capability of turning off and on Audit Cleanup and defining time 

## 1.81 2018-07-18 <dave at tiredofit dot ca>

* Autoexecute argonaut-clean-audit at midnight

## 1.8 2018-07-18 <dave at tiredofit dot ca>

* Tweak Argonaut and LDAP configuration files to allow for argoaut-clean-audit to work properly
    
## 1.7 2018-06-12 <dave at tiredofit dot ca>

* FusionDirectory 1.2.1

## 1.6 2018-04-28 <dave at tiredofit dot ca>

* Add LLNG Authentication Support

## 1.51 2018-03-12 <dave at tiredofit dot ca>
	
* Inject 1.3-dev code for Displaying Groups of Groups

## 1.5 2018-02-01 <dave at tiredofit dot ca>

* Rebase

## 1.41 2018-01-23 <dave at tiredofit dot ca>

* Fix Custom Welcome Email location

## 1.4 2018-01-12 <dave at tiredofit dot ca>

* Merged css and plugins repositories to one (/assets/custom)

## 1.3 2017-10-17 <dave at tiredofit dot ca>

* Tweak to custom plugins installation.

## 1.2 2017-09-28 <dave at tiredofit dot ca>

* Fixed Multiple Instances not appearing if over 3 on Frontend.

## 1.1 2017-09-27 <dave at tiredofit dot ca>

* Added Custom Plugin Installation upon startup - Just map a volume to /assets/plugins-custom and it will automatically install (provided the folders are setup similar to how FD Original Plugins are defined

## 1.0 2017-09-17 <dave at tiredofit dot ca>

* Argonaut Server Installed
* All Plugins can be enabled or disabled depending on environment
* PHP 7.1
* Alpine 3.6


## 0.1 2017-08-24 <dave at tiredofit dot ca>

* Initial Development Release
* Nginx, PHP-FPM 7.0
* Alpine 3.5

