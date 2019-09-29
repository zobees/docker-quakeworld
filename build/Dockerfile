FROM ubuntu

USER root

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget ca-certificates bash dos2unix unzip golang

ENV BUILD_DIR=/qw-build \
    DEST_DIR=/qw-dest

WORKDIR $BUILD_DIR

CMD $BUILD_DIR/build.sh
