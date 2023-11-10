FROM ipv4v6/go:1.20.11-bookworm as builder

RUN go install -v github.com/hashicorp/packer@latest

FROM scratch
COPY --from=builder /root/go/bin/packer /packer
