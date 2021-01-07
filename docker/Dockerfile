FROM aoirint/transproxy:node

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY

ARG JOPLIN_URL=https://github.com/laurent22/joplin
ARG JOPLIN_CHECKOUT=9cb576889f98c15e860ceae9df5763cccf126a1f

RUN  { \
    echo 'Acquire::http::proxy "'${HTTP_PROXY}'";'; \
    echo 'Acquire::https::proxy "'${HTTPS_PROXY}'";'; \
} | tee /etc/apt/apt.conf && \
    apt update && apt install -y \
        git \
        rsync \
        libnss3 \
        libsecret-1-dev \
        libfontconfig1 \
        libx11-xcb-dev \
        libxcb-dri3-dev \
        libxtst-dev \
        libatk-bridge2.0-dev \
        libgtk-3-dev \
        libasound2-dev \
        fonts-noto \
        gosu && \
    rm /etc/apt/apt.conf && \
    rm -rf /var/lib/apt/lists/* && \
    fc-cache && \
    gosu node git clone ${JOPLIN_URL} /home/node/joplin && \
    cd /home/node/joplin && \
    gosu node git checkout ${JOPLIN_CHECKOUT} && \
    gosu node npm install && \
    cd /home/node/joplin/packages/app-desktop && \
    chown root:root ./node_modules/electron/dist/chrome-sandbox && \
    chmod 4755 ./node_modules/electron/dist/chrome-sandbox && \
    gosu node npm run env -- gulp build

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]

WORKDIR "/home/node/joplin/packages/app-desktop"
CMD [ "npm", "run", "env", "--", "electron", "." ]
