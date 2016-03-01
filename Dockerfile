FROM golang:1.6

ENV GO15VENDOREXPERIMENT 0
ENV VERSION 1.13

ADD . /go/src/github.com/apiaryio/dnsdock

RUN cd /go/src/github.com/apiaryio/dnsdock && \
    go get -v github.com/tools/godep && \
    godep restore && \
    go install -ldflags "-X main.version $VERSION" ./...

ENTRYPOINT ["/go/bin/dnsdock"]
