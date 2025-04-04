module proto-builder

require (
	golang.org/x/net v0.38.0 // indirect
	google.golang.org/grpc v1.71.1 // indirect
	google.golang.org/protobuf v1.36.6 // indirect
)

require (
	github.com/google/go-cmp v0.7.0 // indirect
	github.com/planetscale/vtprotobuf v0.6.1-0.20250313105119-ba97887b0a25 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250324211829-b45e905df463 // indirect
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.5.1 // indirect
	storj.io/drpc v0.0.34 // indirect
)

tool (
	github.com/planetscale/vtprotobuf/cmd/protoc-gen-go-vtproto
	google.golang.org/grpc/cmd/protoc-gen-go-grpc
	google.golang.org/protobuf/cmd/protoc-gen-go
	storj.io/drpc/cmd/protoc-gen-go-drpc
)

go 1.24
