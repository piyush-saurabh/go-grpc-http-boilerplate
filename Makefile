# Install dependencies
setup:
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
	go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

	cp -r $(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.14.3/third_party/googleapis/google/ third_party/google

	cp -r  $(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@v1.14.3/protoc-gen-swagger/options/ third_party/protoc-gen-swagger/options/


# Generate protobuf
proto:
	protoc --proto_path=api/proto/v1 --proto_path=third_party --go_out=plugins=grpc:pkg/api/v1 todo.proto

	protoc --proto_path=api/proto/v1 --proto_path=third_party --grpc-gateway_out=logtostderr=true:pkg/api/v1 todo.proto

	protoc --proto_path=api/proto/v1 --proto_path=third_party --swagger_out=logtostderr=true:api/swagger/v1 todo.proto

run-server:
	go build cmd/todo/server/*.go 

run-client:
	cd cmd/todo/client
	go build . -server=localhost:9090

