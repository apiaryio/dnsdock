FROM alpine
MAINTAINER sre@apiary.io

ENV REFRESHED_AT 2016-12-15

RUN mkdir -p /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

COPY bin/dnsdock /go/bin

ENTRYPOINT ["/go/bin/dnsdock"]
