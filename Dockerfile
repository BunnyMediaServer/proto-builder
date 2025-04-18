FROM golang:1.24
LABEL org.opencontainers.image.source="https://github.com/BunnyMediaServer/proto-builder"
WORKDIR /tmp

# Set env variables, stabilize versions of each compiler component
RUN echo "${PATH}"
ENV PROTOBUF_VERSION="30.2"
ENV PROTOC_ZIP="protoc-${PROTOBUF_VERSION}-linux-x86_64.zip"
ENV PROTOC_URL="https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/${PROTOC_ZIP}"
# "https://github.com/protocolbuffers/protobuf/releases/download/v3.20.0-rc1/protoc-3.20.0-rc-1-linux-x86_64.zip"

# Download dependencies
RUN apt-get update && apt-get install -y curl git unzip

# Install protobuf (with our version constraint for stability)
RUN echo "Downloading protobuf compiler from: ${PROTOC_URL}"
RUN wget "${PROTOC_URL}"
RUN unzip "${PROTOC_ZIP}" -d ./protoc_dir
RUN chmod 755 -R ./protoc_dir/bin && chmod +x -R ./protoc_dir/bin
RUN cd protoc_dir/bin && ls -R && ./protoc --version
ENV BASE="/usr/local"
RUN cp ./protoc_dir/bin/protoc "${BASE}/bin/"
RUN cp -R ./protoc_dir/include/* "${BASE}/include/"
RUN rm -r ./protoc_dir
RUN ls -R "${BASE}/bin/"
RUN rm "${PROTOC_ZIP}"
# Check protobuf is installed
RUN protoc --version

# Setup Golang environment
WORKDIR /proto
COPY . .
RUN cat go.mod
RUN go mod download
RUN go install tool
# Cleanup for execution
RUN rm go.*
