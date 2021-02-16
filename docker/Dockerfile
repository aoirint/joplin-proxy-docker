FROM aoirint/transproxy:node-alpine

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY

ARG JOPLIN_URL=https://github.com/laurent22/joplin
ARG JOPLIN_CHECKOUT=9bfc7d98608f01b02cd0fcbbcc9c0c9d42e9f245

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
        shadow && \
    fc-cache && \
    su-exec node git clone ${JOPLIN_URL} /home/node/joplin && \
    cd /home/node/joplin && \
    su-exec node git checkout ${JOPLIN_CHECKOUT} && \
    rm -rf ./packages/app-cli ./packages/app-clipper ./packages/app-mobile ./packages/server/

RUN cd /home/node/joplin && \
    su-exec node npm install && \
    cd /home/node/joplin/packages/app-desktop && \
    chown root:root ./node_modules/electron/dist/chrome-sandbox && \
    chmod 4755 ./node_modules/electron/dist/chrome-sandbox && \
    su-exec node npm run env -- gulp build

# https://github.com/sgerrand/alpine-pkg-glibc
RUN apk add --no-cache \
        wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
    apk add glibc-2.32-r0.apk

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

WORKDIR "/home/node/joplin/packages/app-desktop"
CMD [ "npm", "run", "env", "--", "electron", "." ]
