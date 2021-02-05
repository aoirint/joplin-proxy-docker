FROM aoirint/transproxy:node

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY

ARG JOPLIN_URL=https://github.com/laurent22/joplin
ARG JOPLIN_CHECKOUT=40a4c69afedc7caa6d8c1ab6b29ef401116fb35b

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
        su-exec && \
    fc-cache && \
    su-exec node git clone ${JOPLIN_URL} /home/node/joplin && \
    cd /home/node/joplin && \
    su-exec node git checkout ${JOPLIN_CHECKOUT} && \
    rm -rf ./packages/app-cli ./packages/app-clipper ./packages/app-mobile ./packages/server/

RUN apk add --no-cache \
        make \
        g++ \
        ca-certificates

RUN cd /home/node/joplin && \
    su-exec node npm install && \
    cd ./packages/app-desktop && \
    chown root:root ./node_modules/electron/dist/chrome-sandbox && \
    chmod 4755 ./node_modules/electron/dist/chrome-sandbox

RUN cd /home/node/joplin && \
    cd ./packages/app-desktop && \
    su-exec node npm run env -- gulp build

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

WORKDIR "/home/node/joplin/packages/app-desktop"
CMD [ "npm", "run", "env", "--", "electron", "." ]
