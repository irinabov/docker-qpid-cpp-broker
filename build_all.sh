#!/bin/bash -ex

home=$PWD
dnf update -y
dnf install -y git
cd $home
./build_proton.sh
cd $home
./build_cpp.sh
cd $home
./cleanup.sh
dnf clean all
exit
