ARG DISTRO=alpine
ARG PHP_VERSION=7.4

FROM docker.io/tiredofit/nginx-php-fpm:${PHP_VERSION}-${DISTRO}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"


## Set Environment Varialbes
ENV ARGONAUT_VERSION=1.4-dev \
    FUSIONDIRECTORY_VERSION=b246399ff2d3dc74565c9f3897e4a3544e0c51d1 \
    FUSIONDIRECTORY_REPO_URL=https://github.com/fusiondirectory/fusiondirectory \
    FUSIONDIRECTORY_PLUGINS_VERSION=b0078c722634cbd42fe2b0231eb8d40c6d87df3e \
    FUSIONDIRECTORY_PLUGINS_REPO_URL=https://github.com/fusiondirectory/fusiondirectory-plugins \
    SCHEMA2LDIF_VERSION=1.3 \
    SMARTY_VERSION=3.1.39 \
    SMARTYGETTEXT_VERSION=1.6.2 \
    INSTANCE=default \
    NGINX_SITE_ENABLED=fusiondirectory \
    NGINX_WEBROOT=/www/fusiondirectory \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_GETTEXT=TRUE \
    PHP_ENABLE_IMAGICK=TRUE \
    PHP_ENABLE_IMAP=TRUE \
    PHP_ENABLE_LDAP=TRUE \
    IMAGE_NAME="tiredofit/fusiondirectory" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-fusiondirectory/"

# Build Dependencies
RUN source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package install .fusiondirectory-build-deps \
                coreutils \
                build-base \
                git \
                make \
                perl-dev \
                && \
    \
## Run Dependencies Installation
    package install .fusiondirectory-run-deps \
                expect \
                gettext \
                gettext-lang \
                openldap \
                openldap-clients \
                perl-config-inifiles \
                perl-datetime \
                perl-ldap \
                perl-mime-base64 \
                perl-crypt-cbc \
                perl-file-copy-recursive \
                perl-io-socket-ssl \
                perl-io-tty \
                perl-json \
                perl-mail-sendmail \
                perl-mime-tools \
                perl-module-pluggable \
                perl-net-ldap \
                perl-path-class \
                perl-term-readkey \
                perl-xml-twig \
                && \
    \
### Install Perl Dependencies that aren't available as package s
    ln -s /usr/bin/perl /usr/local/bin/perl && \
    curl -sSL http://cpanmin.us -o /usr/bin/cpanm && \
    chmod +x /usr/bin/cpanm && \
    cpanm -n \
            App::Daemon \
            Archive::Extract \
            Bytes::Random::Secure \
            HTTP::Daemon \
            JSON::Any \
            JSON::RPC \
            Log::Handler \
            #Mail::Sendmail \
            #Module::Pluggable \
            POE \
            POE::Component::Server::JSONRPC::Http \
            POE::Component::Schedule \
            POE::Component::Server::SimpleHTTP \
            POE::Component::Pool::Thread \
            POE::Component::SSLify \
            XML::SAX::Expat \
            && \
    \
    cp -R /usr/local/share/perl5/site_perl/* /usr/share/perl5/vendor_perl/ && \
    \
## Install Smarty3
    mkdir -p /usr/src/smarty /usr/src/smarty-gettext /usr/share/php/smarty3 && \
    curl -sSL https://codeload.github.com/smarty-php/smarty/tar.gz/v${SMARTY_VERSION} | tar xfz - --strip 1 -C /usr/src/smarty && \
    cp -r /usr/src/smarty/libs/* /usr/share/php/smarty3 && \
    ln -s /usr/share/php/smarty3/Smarty.class.php /usr/share/php/smarty3/smarty.class.php && \
    curl -sSL https://codeload.github.com/smarty-gettext/smarty-gettext/tar.gz/${SMARTYGETTEXT_VERSION} | tar xfz - --strip 1 -C /usr/src/smarty-gettext && \
    mkdir -p /usr/share/php/smarty3/plugins && \
    cp -R /usr/src/smarty-gettext/block.t.php /usr/share/php/smarty3/plugins/ && \
    cp -R /usr/src/smarty-gettext/tsmarty2c.php /usr/sbin && \
    chmod 750 /usr/sbin/tsmarty2c.php && \
    \
## Install Schema2LDIF
    curl https://codeload.github.com/fusiondirectory/schema2ldif/tar.gz/${SCHEMA2LDIF_VERSION} | tar xvfz - --strip 1 -C /usr && \
    rm -rf /usr/Changelog && \
    rm -rf /usr/LICENSE && \
    \
## Install Communication Server
    mkdir -p /usr/src/argonaut /etc/argonaut /var/log/argonaut && \
    git clone https://gitlab.fusiondirectory.org/fusiondirectory/argonaut /usr/src/argonaut && \
    cd /usr/src/argonaut && \
    git checkout ${ARGONAUT_VERSION} && \
    chmod +x /usr/src/argonaut/*/bin/* && \
    cp -R /usr/src/argonaut/argonaut-common/Argonaut /usr/share/perl5/vendor_perl/ && \
    cp -R /usr/src/argonaut/argonaut-common/XML /usr/share/perl5/vendor_perl/ && \
    cp -R /usr/src/argonaut/argonaut-common/argonaut.conf /etc/argonaut && \
    cp -R /usr/src/argonaut/argonaut-fusiondirectory/bin/* /usr/sbin && \
    cp -R /usr/src/argonaut/argonaut-fusioninventory/bin/* /usr/sbin && \
    cp -R /usr/src/argonaut/argonaut-server/bin/argonaut-server /usr/sbin && \
    cp -R /usr/src/argonaut/argonaut-server/Argonaut /usr/share/perl5/vendor_perl/ && \
    cp -R /usr/src/argonaut/*/Argonaut/ /usr/share/perl5/vendor_perl && \
    \
## Install FusionDirectory
    clone_git_repo "${FUSIONDIRECTORY_REPO_URL}" "${FUSIONDIRECTORY_VERSION}" /usr/src/fusiondirectory && \
    clone_git_repo "${FUSIONDIRECTORY_PLUGINS_REPO_URL}" "${FUSIONDIRECTORY_PLUGINS_VERSION}" /assets/fusiondirectory-plugins && \
    \
## Install Extra FusionDirectory Plugins
    clone_git_repo https://github.com/tiredofit/fusiondirectory-plugin-kopano main /usr/src/fusiondirectory-plugin-kopano && \
    cp -R /usr/src/fusiondirectory-plugin-kopano/kopano /assets/fusiondirectory-plugins/ && \
    clone_git_repo https://github.com/slangdaddy/fusiondirectory-plugin-nextcloud master /usr/src/fusiondirectory-plugin-nextcloud && \
    rm -rf /usr/src/fusiondirectory-plugin-nextcloud/src/DEBIAN && \
    mkdir -p /assets/fusiondirectory-plugins/nextcloud && \
    cp -R /usr/src/fusiondirectory-plugin-nextcloud/src/* /assets/fusiondirectory-plugins/nextcloud/ && \
    clone_git_repo https://github.com/gallak/fusiondirectory-plugins-seafile master /usr/src/fusiondirectory-plugins-seafile && \
    rm -rf /usr/src/fusiondirectory-plugins-seafile/README.md && \
    mkdir -p /assets/fusiondirectory-plugins/seafile && \
    cp -R /usr/src/fusiondirectory-plugins-seafile/* /assets/fusiondirectory-plugins/seafile/ && \
    \
## Configure FusionDirectory
    mkdir -p /usr/src/javascript && \
    cd /usr/src/javascript && \
    curl -sSL -O http://ajax.googleapis.com/ajax/libs/prototype/1.7.3.0/prototype.js && \
    curl -sSL -O http://script.aculo.us/dist/scriptaculous-js-1.9.0.zip && \
    unzip -d . scriptaculous-js-1.9.0.zip && \
    cp -R prototype.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/scriptaculous.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/builder.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/controls.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/dragdrop.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/effects.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/sound.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/slider.js /usr/src/fusiondirectory/html/include && \
    chmod 750 /usr/src/fusiondirectory/contrib/bin/* && \
    cp -R /usr/src/fusiondirectory/contrib/bin/* /usr/sbin/ && \
    cp -R /usr/src/fusiondirectory/contrib/smarty/plugins/* /usr/share/php/smarty3/plugins/ && \
    mkdir -p /var/spool/fusiondirectory/ && \
    mkdir -p /var/cache/fusiondirectory/ && \
    mkdir -p /var/cache/fusiondirectory/fai && \
    mkdir -p /var/cache/fusiondirectory/include && \
    mkdir -p /var/cache/fusiondirectory/locale && \
    mkdir -p /var/cache/fusiondirectory/template && \
    mkdir -p /var/cache/fusiondirectory/tmp && \
    mkdir -p /etc/fusiondirectory && \
    cp -R /usr/src/fusiondirectory/contrib/fusiondirectory.conf /var/cache/fusiondirectory/template/fusiondirectory.conf && \
    #php-ext enable core && \
    mkdir -p ${NGINX_WEBROOT} && \
    cp -R /usr/src/fusiondirectory/* ${NGINX_WEBROOT} && \
    fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --write-vars --yes && \
    fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --set-fd_smarty_path="/usr/share/php/smarty3/Smarty.class.php" --write-vars --yes && \
    touch /etc/debian_version && \
    yes Yes | fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --check-directories --update-cache && \
    fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --update-locales --update-cache --yes && \
#    sed -i -e "s#= \$_SERVER\\['PHP_SELF'\\];#= '/recovery.php';#g" ${NGINX_WEBROOT}/html/class_passwordRecovery.inc && \
    \
    ### Cleanup
    package remove .fusiondirectory-build-deps && \
    package cleanup && \
    rm -rf \
           /usr/src/* \
           /root.cpanm \
           /tmp/*

COPY install /
