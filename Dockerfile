FROM golang:alpine
WORKDIR /proto

# Set env variables, stabilize versions of each compiler component
ENV PROTOBUF_VERSION "3.18"
ENV VT_VERSION "v0.2.0"

# Download dependencies
COPY go.* ./
RUN apk update && apk --no-cache add curl git && apk --no-cache add protoc~=${PROTOBUF_VERSION} protobuf-dev~=${PROTOBUF_VERSION} --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main
RUN go install \
            google.golang.org/protobuf/cmd/protoc-gen-go \
            google.golang.org/grpc/cmd/protoc-gen-go-grpc \
            github.com/planetscale/vtprotobuf/cmd/protoc-gen-go-vtproto \
            storj.io/drpc/cmd/protoc-gen-go-drpc
RUN go mod download
# Cleanup for execution
RUN rm go.*
