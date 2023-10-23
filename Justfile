set dotenv-load := true

TAG := `git describe --tags --always --dirty`
BASE_IMAGE_NAME := "base-nb-vscode-cuda-11.8"
CODESERVER_IMAGE_NAME := "codeserver"

default: push-coder push-base

echo:
    #!/usr/bin/env bash
    echo $REGISTRY
    echo {{TAG}}
    echo {{BASE_IMAGE_NAME}}

build-base:
    docker build -t $REGISTRY/{{BASE_IMAGE_NAME}}:{{TAG}} -t $REGISTRY/{{BASE_IMAGE_NAME}}:latest -f base/Dockerfile .

push-base: build-base
    docker push $REGISTRY/{{BASE_IMAGE_NAME}}:{{TAG}}
    docker push $REGISTRY/{{BASE_IMAGE_NAME}}:latest

build-coder: build-base
    docker build -t $REGISTRY/{{CODESERVER_IMAGE_NAME}}:{{TAG}} -t $REGISTRY/{{CODESERVER_IMAGE_NAME}}:latest --build-arg BASE_IMG=$REGISTRY/{{BASE_IMAGE_NAME}}:{{TAG}} -f codeserver/Dockerfile .

push-coder: build-coder
    docker push $REGISTRY/{{CODESERVER_IMAGE_NAME}}:{{TAG}}
    docker push $REGISTRY/{{CODESERVER_IMAGE_NAME}}:latest
