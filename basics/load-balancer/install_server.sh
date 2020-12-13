#!/bin/bash
yum update -y
yum install git -y
yum install go -y

git clone https://github.com/vungocson998/simple-go-server.git -b master
cd simple-go-server

go build -o main main.go
./main