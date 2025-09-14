FROM ipv4v6/go:1.21.13-bookworm as builder

ENV GOPROXY=https://proxy.golang.org,direct
ENV CGO_ENABLED=0
RUN git clone --depth 1 --branch v1.11.2 https://github.com/hashicorp/packer && \
	cd packer && \
	go build -v -a -ldflags '-extldflags "-static"' -o /root/

FROM scratch
COPY --from=builder /root/packer /packer
