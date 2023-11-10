FROM ipv4v6/go:1.20.11-bookworm as builder

ENV CGO_ENABLED=0
RUN go install -v -a -ldflags '-extldflags "-static"' github.com/hashicorp/packer@v1.9.4

FROM scratch
COPY --from=builder /root/go/bin/packer /packer
