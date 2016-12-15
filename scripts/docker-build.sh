#!/bin/bash

docker build -t dnsdock_base -f Dockerfile.base .
docker run -v "${PWD}"/bin:/go/bin -it dnsdock_base
docker build -t apiaryio/dnsdock .
