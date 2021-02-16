FROM node:12-alpine

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY


ARG GLIBC_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk
ARG GLIBC_BIN_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-bin-2.32-r0.apk
ARG GLIBC_I18N_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-i18n-2.32-r0.apk

# https://github.com/sgerrand/alpine-pkg-glibc
RUN apk add --no-cache \
        wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget "${GLIBC_URL}" && \
    wget "${GLIBC_BIN_URL}" && \
    wget "${GLIBC_I18N_URL}" && \
    apk add glibc-2.32-r0.apk glibc-bin-2.32-r0.apk glibc-i18n-2.32-r0.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib


ARG TRANSPROXY_URL=https://github.com/wadahiro/go-transproxy/releases/download/v0.5.2/go-transproxy-0.5.2.tar.gz

# https://github.com/wadahiro/go-transproxy
RUN apk add --no-cache \
        wget \
        iptables && \
    mkdir -p /usr/local/transproxy && \
    wget ${TRANSPROXY_URL} -O - | tar zx -C /usr/local/transproxy && \
    ln -s /usr/local/transproxy/bin/transproxy /usr/local/bin/


ARG JOPLIN_URL=https://github.com/laurent22/joplin
ARG JOPLIN_CHECKOUT=9bfc7d98608f01b02cd0fcbbcc9c0c9d42e9f245

# https://github.com/laurent22/joplin
RUN apk add --no-cache \
        git \
        rsync \
        nss \
        libsecret-dev \
        fontconfig-dev \
        libx11-dev \
        libxcb-dev \
        libxtst-dev \
        at-spi2-atk-dev \
        gtk+3.0-dev \
        alsa-lib-dev \
        font-noto \
        su-exec \
        make \
        g++ \
        shadow \
        glib && \
    fc-cache && \
    su-exec node git clone ${JOPLIN_URL} /home/node/joplin && \
    cd /home/node/joplin && \
    su-exec node git checkout ${JOPLIN_CHECKOUT} && \
    rm -rf ./packages/app-cli ./packages/app-clipper ./packages/app-mobile ./packages/server/ && \
    su-exec node npm install && \
    cd /home/node/joplin/packages/app-desktop && \
    chown root:root ./node_modules/electron/dist/chrome-sandbox && \
    chmod 4755 ./node_modules/electron/dist/chrome-sandbox && \
    su-exec node npm run env -- gulp build

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

WORKDIR "/home/node/joplin/packages/app-desktop"
CMD [ "npm", "run", "env", "--", "electron", "." ]
