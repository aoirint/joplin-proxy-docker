FROM aoirint/transproxy:node

ARG HTTP_PROXY
ARG HTTPS_PROXY

ARG JOPLIN_URL=https://github.com/laurent22/joplin
ARG JOPLIN_CHECKOUT=9cb576889f98c15e860ceae9df5763cccf126a1f

RUN apt update && apt install -y \
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
    fc-cache && \
    useradd -m joplin && \
    gosu joplin git clone ${JOPLIN_URL} /home/joplin/joplin && \
    cd /home/joplin/joplin && \
    gosu joplin git checkout ${JOPLIN_CHECKOUT} && \
    gosu joplin npm install && \
    cd /home/joplin/joplin/packages/app-desktop && \
    chown root:root ./node_modules/electron/dist/chrome-sandbox && \
    chmod 4755 ./node_modules/electron/dist/chrome-sandbox && \
    gosu joplin npm run env -- gulp build

USER joplin
WORKDIR "/home/joplin/joplin/packages/app-desktop"
CMD [ "npm", "run", "env", "--", "electron", "." ]
