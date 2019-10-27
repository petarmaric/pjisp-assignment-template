#!/bin/sh

VERSION="1.0.0"

docker run --rm -it --user="$(id -u):$(id -g)" --net=none --volume="$PWD":/app petarmaric/pjisp-assignment-template:$VERSION $*
