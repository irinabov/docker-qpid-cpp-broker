#!/bin/bash -ex

dnf install -y $(cat proton_build_dependencies.txt)
git clone git://git.apache.org/qpid-proton.git qpid-proton
cd qpid-proton
git checkout $QPID_PROTON_VERSION
cmake -DBUILD_CPP=OFF -DBUILD_PYTHON=OFF .
make -j4
make install
exit
