FROM ipv4v6/go:1.16.13-bullseye as builder

ENV GO111MODULE=on
ENV CGO_ENABLED=0
RUN go get -v -a -ldflags '-extldflags "-static"' github.com/hashicorp/packer@v1.7.8

FROM scratch
COPY --from=builder /root/go/bin/packer /packer
