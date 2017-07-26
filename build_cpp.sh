#!/bin/bash -ex

dnf install -y $(cat cpp_build_dependencies.txt)

git clone git://git.apache.org/qpid-cpp.git    qpid-cpp
(cd qpid-cpp; git checkout $QPID_CPP_VERSION)
git clone git://git.apache.org/qpid-python.git qpid-python
(cd qpid-python; git checkout $QPID_PYTHON_VERSION; python setup.py install)

cd $home/qpid-cpp
mkdir -p build
cd build
GCC7FLAG="-Wno-implicit-fallthrough -Wno-deprecated-declarations -Wno-error=maybe-uninitialized"
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo "-DCMAKE_CXX_FLAGS=$GCC7FLAG $CXXFLAGS" ..
make -j4
make install
rm /usr/local/lib64/qpid/daemon/store.so

exit
