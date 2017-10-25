#!/bin/bash -ex
#
docker build --build-arg version=devel -t irinabov/docker-qpid-cpp-broker:devel . | tee build-devel.log
exit

