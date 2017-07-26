#!/bin/bash -ex

dnf install -y $(cat proton_build_dependencies.txt)

git clone git://git.apache.org/qpid-proton.git qpid-proton
(cd qpid-proton && git checkout $QPID_PROTON_VERSION)

cd qpid-proton
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DSYSINSTALL_BINDINGS=OFF ..
make -j4
make install

exit
