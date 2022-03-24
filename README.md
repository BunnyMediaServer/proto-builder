# proto-builder
This image we use to build our Protobuf code from IDL, this is containerized to prevent cross platform issues.

### Usage guide
Just use this example to set-up your containerized compiler:
```
FROM ghcr.io/bunnymediaserver/proto-builder:v0.0.1 AS builder
WORKDIR /proto

# Copy our repo
COPY . ./

# Setup general includes
ENV PROTO_INC "-I ./ \
  -I ../ \
  -I ../../ \
  -I $GOPATH/src \
  -I $GOPATH/pkg/mod"

ENV PROTOC_VT_DRPC "protoc ${PROTO_INC} --go_out=. --plugin protoc-gen-go=${GOPATH}/bin/protoc-gen-go --go-grpc_out=. --plugin protoc-gen-go-grpc=${GOPATH}/bin/protoc-gen-go-grpc --go-vtproto_out=. --plugin protoc-gen-go-vtproto=${GOPATH}/bin/protoc-gen-go-vtproto --go-vtproto_opt=features=marshal+unmarshal+size --go-drpc_out=. --plugin protoc-gen-go-drpc=${GOPATH}/bin/protoc-gen-go-drpc --go-drpc_opt=protolib=github.com/planetscale/vtprotobuf/codec/drpc ./*.proto"
ENV TARGETS "config"
# Generate services
RUN for target in ${TARGETS}; do cd /proto/$target && ${PROTOC_VT_DRPC} && find . -name "*.go" -type f -exec cp {} /proto/$target \; && rm -r /proto/$target/github.com; done

CMD ["/bin/sh", "-c", "echo Docker done"]
```

