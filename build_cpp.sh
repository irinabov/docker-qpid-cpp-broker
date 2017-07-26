#!/bin/bash -ex

dnf install -y $(cat cpp_build_dependencies.txt)
git clone git://git.apache.org/qpid-cpp.git qpid-cpp
cd qpid-cpp
git checkout $QPID_CPP_VERSION
GCC7FLAG="-Wno-implicit-fallthrough -Wno-deprecated-declarations -Wno-error=maybe-uninitialized"
cmake -DBUILD_BINDING_PYTHON=OFF -DBUILD_BINDING_RUBY=OFF -DBUILD_DOCS=OFF -DBUILD_TESTING=OFF -DINSTALL_QMFGEN=OFF "-DCMAKE_CXX_FLAGS=$GCC7FLAG $CXXFLAGS" .
make -j4
make install
rm -f /usr/local/lib64/qpid/daemon/store.so

exit
