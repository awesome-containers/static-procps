# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# hadolint ignore=DL3018
RUN apk add --no-cache libtool

# https://gitlab.com/procps-ng/procps
ARG PROCPS_VERSION=4.0.3

WORKDIR /src/procps
RUN set -xeu; \
    curl -#Lo procps.tar.gz \
        "https://gitlab.com/procps-ng/procps/-/archive/v$PROCPS_VERSION/procps-master.tar.gz"; \
    tar -xvf procps.tar.gz --strip-components=1; \
    rm -f procps.tar.gz

ARG CFLAGS='-w -g -Os -static'
# hadolint ignore=SC2044,DL4006
RUN set -xeu; \
    ./autogen.sh; \
    ./configure --enable-static --disable-shared -without-ncurses --disable-w LDFLAGS=--static; \
    make -j"$(nproc)"; \
    mkdir bin; \
    for bin in $(find ./src/ -executable -type f); do \
        ! ldd "$bin" && :; \
        strip -s -R .comment --strip-unneeded "$bin"; \
        mv "$bin" bin/; \
    done; \
    mv bin/pscommand bin/ps; rm -f top slabtop; \
    chmod -cR 755 bin; \
    chown -cR 0:0 bin; \
    ./bin/sysctl --version

# static procps image
FROM static-bash
COPY --from=build /src/procps/bin/ /bin/
