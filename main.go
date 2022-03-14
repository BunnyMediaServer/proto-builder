package main

import (
	"github.com/planetscale/vtprotobuf/codec/drpc"
	"google.golang.org/genproto/protobuf/api"
	_ "google.golang.org/grpc"
	"google.golang.org/protobuf/proto"
	drpc2 "storj.io/drpc"
)

func main() {
	// Just to hold dependencies in place
	_, _ = drpc.Marshal(api.Api{})
	_, _ = drpc.Marshal(drpc2.Error)
	_, _ = proto.Marshal(nil)
}
