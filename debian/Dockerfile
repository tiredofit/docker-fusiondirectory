FROM tiredofit/debian:stretch
MAINTAINER Dave Conroy <daveconroy@selfdesign.org>

### Set Environment Variables
  ENV FUSIONDIRECTORY_VERSION=1.2

### Add FusionDirectory Repository
  RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 0xD744D55EACDA69FF && \
      echo "deb http://repos.fusiondirectory.org/fusiondirectory-releases/fusiondirectory-1.2/debian-jessie jessie main" > /etc/apt/sources.list.d/fusiondirectory-jessie.list && \
      echo "deb http://repos.fusiondirectory.org/fusiondirectory-extra/debian-jessie jessie main" >> /etc/apt/sources.list.d/fusiondirectory-jessie.list && \
      apt-get update

### Install Fusion Directory and Dependencies
  RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
      #argonaut-server \
      fusiondirectory \
      #fusiondirectory-plugin-alias \
      #fusiondirectory-plugin-applications \
      #fusiondirectory-plugin-argonaut \
      fusiondirectory-plugin-audit \
      #fusiondirectory-plugin-autofs \
      #fusiondirectory-plugin-certificates \
      #fusiondirectory-plugin-dovecot \
      fusiondirectory-plugin-dsa \
      #fusiondirectory-plugin-gpg \
      fusiondirectory-plugin-ldapdump \
      fusiondirectory-plugin-ldapmanager \
      fusiondirectory-plugin-mail \
      #fusiondirectory-plugin-mixedgroups \
      fusiondirectory-plugin-personal \
      #fusiondirectory-plugin-postfix \
      fusiondirectory-plugin-ppolicy \
      #fusiondirectory-plugin-quota \
      fusiondirectory-plugin-ssh \
      fusiondirectory-plugin-sudo \
      fusiondirectory-plugin-systems \
      #fusiondirectory-plugin-weblink \
      #fusiondirectory-plugin-webservice \
      fusiondirectory-smarty3-acl-render \
      #fusiondirectory-webservice-shell \
      nginx \
      php-mdb2 \
      php-mbstring \
      php-fpm \
      && \

### Cleanup
     rm -rf /var/lib/apt/lists/* && \
     apt-get clean 

### Files Setup
  ADD install /

### Networking Setup  
  EXPOSE 80 443

