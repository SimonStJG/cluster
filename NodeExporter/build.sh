#!/bin/bash
set -ex

GOOS=linux GOARCH=arm GOARM=5 go get github.com/prometheus/node_exporter
cp $GOPATH/bin/linux_arm/node_exporter ./bin
upx -qq --best ./bin/node_exporter
