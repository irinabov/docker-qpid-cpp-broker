#!/bin/bash -ex
#
docker build -t irinabov/docker-qpid-cpp-broker . | tee build-latest.log
exit

