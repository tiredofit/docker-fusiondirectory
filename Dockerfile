FROM tiredofit/nginx-php-fpm:7.0-latest
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

## Set Environment Varialbes
ENV FUSIONDIRECTORY_VERSION=1.2 \
    SCHEMA2LDIF_VERSION=1.3 \
    SMARTY_VERSION=3.1.30 \
    SMARTYGETTEXT_VERSION=1.5.1 \
    INSTANCE=default


# Build Dependencies
RUN apk update && \
    apk add --no-cache --virtual build-deps \
            coreutils \
            build-base \
            make \
            perl-dev
          
## Dependency Installation
RUN apk add \
        gettext \
        perl-path-class \
        perl-ldap \
        perl-mime-base64 \
        perl-crypt-cbc \
        perl-file-copy-recursive \
        perl-term-readkey \
        perl-xml-twig \
        php7-gettext 

  RUN ln -s /usr/bin/perl /usr/local/bin/perl && \
      curl -L http://cpanmin.us -o /usr/bin/cpanm && \
      chmod +x /usr/bin/cpanm && \
      cpanm -n \
      Archive::Extract && \
      cp -R /usr/local/share/perl5/site_perl/* /usr/share/perl5/vendor_perl/ && \
  
  # Cleanup
      rm -rf /root/.cpanm && \
      apk del build-deps && \
      rm -rf /tmp/* /var/cache/apk/* 

## Install Smarty3
RUN mkdir -p /usr/src/smarty /usr/src/smarty-gettext /usr/share/php/smarty3 && \
    curl https://codeload.github.com/smarty-php/smarty/tar.gz/v${SMARTY_VERSION} | tar xvfz - --strip 1 -C /usr/src/smarty && \
    cp -r /usr/src/smarty/libs/* /usr/share/php/smarty3 && \
    ln -s /usr/share/php/smarty3/Smarty.class.php /usr/share/php/smarty3/smarty.class.php && \
    curl https://codeload.github.com/smarty-gettext/smarty-gettext/tar.gz/${SMARTYGETTEXT_VERSION} | tar xvfz - --strip 1 -C /usr/src/smarty-gettext && \   
    mkdir -p /usr/share/php/smarty3/plugins && \
    cp -R /usr/src/smarty-gettext/block.t.php /usr/share/php/smarty3/plugins/ && \
    cp -R /usr/src/smarty-gettext/tsmarty2c.php /usr/sbin && \
    chmod 750 /usr/sbin/smarty-gettext/tsmarty2c.php

## Install Schema2LDIF
RUN curl https://codeload.github.com/fusiondirectory/schema2ldif/tar.gz/${SCHEMA2LDIF_VERSION} | tar xvfz - --strip 1 -C /usr && \
    rm -rf /usr/CHANGELOG && \
    rm -rf /usr/LICENSE && \

## Install FusionDirextory
    mkdir -p /usr/src/fusiondirectory /usr/src/fusiondirectory-plugins && \
    curl https://codeload.github.com/fusiondirectory/fusiondirectory/tar.gz/fusiondirectory-${FUSIONDIRECTORY_VERSION} | tar xvfz - --strip 1 -C /usr/src/fusiondirectory && \
    curl https://codeload.github.com/fusiondirectory/fusiondirectory-plugins/tar.gz/fusiondirectory-${FUSIONDIRECTORY_VERSION} | tar xvfz - --strip 1 -C /usr/src/fusiondirectory-plugins

## Configure FusionDirectory
RUN mkdir -p /usr/src/javascript && \
    cd /usr/src/javascript && \
    curl -O http://ajax.googleapis.com/ajax/libs/prototype/1.7.1.0/prototype.js && \
    curl -O http://script.aculo.us/dist/scriptaculous-js-1.9.0.zip && \
    unzip -d . scriptaculous-js-1.9.0.zip && \
    cp -R prototype.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/scriptaculous.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/builder.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/controls.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/dragdrop.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/effects.js /usr/src/fusiondirectory/html/include && \
    chmod 750 /usr/src/fusiondirectory/contrib/bin/* && \
    cp -R /usr/src/fusiondirectory/contrib/bin/* /usr/sbin/ && \
    cp /usr/src/fusiondirectory/contrib/smarty/plugins/function.msgPool.php /usr/share/php/smarty3/plugins/function.msgPool.php && \
    cp /usr/src/fusiondirectory/contrib/smarty/plugins/function.filePath.php /usr/share/php/smarty3/plugins/function.filePath.php && \
    mkdir -p /var/spool/fusiondirectory/ && \
    mkdir -p /var/cache/fusiondirectory/ && \
    mkdir -p /var/cache/fusiondirectory/fai && \
    mkdir -p /var/cache/fusiondirectory/include && \
    mkdir -p /var/cache/fusiondirectory/locale && \
    mkdir -p /var/cache/fusiondirectory/template && \
    mkdir -p /var/cache/fusiondirectory/tmp && \
    mkdir -p /etc/fusiondirectory && \

    cp -R /usr/src/fusiondirectory /www && \
    fusiondirectory-setup --set-fd_home="/www/fusiondirectory" --write-vars && \
    fusiondirectory-setup --set-fd_home="/www/fusiondirectory" --set-fd_smarty_dir="/usr/share/php/smarty3/Smarty.class.php" --write-vars && \
    touch /etc/debian_version && \
    yes Yes | fusiondirectory-setup --set-fd_home=/www/fusiondirectory --check-directories --update-cache && \
    fusiondirectory-setup --set-fd_home="/www/fusiondirectory" --update-locales --update-cache 
    
### S6 Setup
  ADD install/s6 /etc/s6

### Nginx Setup
  ADD install/nginx /etc/nginx

