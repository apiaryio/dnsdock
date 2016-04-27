FROM golang:1.6

ENV GO15VENDOREXPERIMENT 1
ENV VERSION 1.13.1

ADD . /go/src/github.com/apiaryio/dnsdock

ADD https://github.com/Masterminds/glide/releases/download/0.9.1/glide-0.9.1-linux-amd64.tar.gz /tmp/glide-0.9.1-linux-amd64.tar.gz
RUN cd /tmp && \
    tar -zxvf /tmp/glide-0.9.1-linux-amd64.tar.gz && \
    cp /tmp/linux-amd64/glide /usr/local/bin/glide && \
    chmod 755 /usr/local/bin/glide && \
    rm /tmp/glide-0.9.1-linux-amd64.tar.gz && rm -rf /tmp/linux-amd64/

RUN cd /go/src/github.com/apiaryio/dnsdock && \
    glide install && \
    go install -ldflags "-X main.version=$VERSION" ./...

WORKDIR /go/src/github.com/apiaryio/dnsdock
ENTRYPOINT ["/go/bin/dnsdock"]
