#!/bin/sh

glide install && \
go install -ldflags "-X main.version=$VERSION" ./...
