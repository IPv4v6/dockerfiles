FROM ipv4v6/go:1.13.8-stretch as builder

RUN go get -v github.com/hashicorp/packer

FROM scratch
COPY --from=builder /root/go/bin/packer /packer
