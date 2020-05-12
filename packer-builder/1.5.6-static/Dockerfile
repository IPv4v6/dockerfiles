FROM ipv4v6/go:1.13.8-stretch as builder

ENV GO111MODULE=on
ENV CGO_ENABLED=0
RUN go get -v -a -ldflags '-extldflags "-static"' github.com/hashicorp/packer@v1.5.6

FROM scratch
COPY --from=builder /root/go/bin/packer /packer
