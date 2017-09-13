#!/bin/bash
set -ex

GOOS=linux GOARCH=arm  GOARM=5 go get github.com/docker/distribution/cmd/registry
cp $GOPATH/bin/linux_arm/registry ./bin
