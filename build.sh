#!/bin/bash -ex
#
if [ "$VERSION" = "latest" ] || [ "$VERSION" = "devel" ]; then
  echo "VERSION is $VERSION..."
else
  echo "VERSION $VERSION is not supported"
fi
#
home=$PWD
dnf update -y
#
# for proton <= 0.17.0 (latest now is 0.18.0), use compat-openssl10, otherwise use openssl
#
export openssl=openssl
#
# Install build dependencies
#
dnf install -y git gcc gcc-c++ cmake make swig pkgconfig libuuid-devel ${openssl}-devel python-devel python2-devel python3-devel cyrus-sasl-devel \
boost-devel boost-filesystem boost-program-options cyrus-sasl-lib libaio-devel libdb4-cxx-devel libibverbs-devel librdmacm-devel nspr-devel nss-devel pkgconfig python-setuptools xerces-c-devel xqilla-devel ruby ruby-devel
#
# Build and install proton bits
#
git clone git://git.apache.org/qpid-proton.git
cd qpid-proton
if [ "$VERSION" = "latest" ]; then
  git checkout $QPID_PROTON_VERSION
fi
cmake -DBUILD_CPP=OFF -DSYSINSTALL_BINDINGS=ON -DSYSINSTALL_PYTHON=ON -DCMAKE_INSTALL_PREFIX=/usr .
make
make install
cd $home
#
# Build and install cpp bits
#
git clone git://git.apache.org/qpid-cpp.git
cd qpid-cpp
if [ "$VERSION" = "latest" ]; then
  git checkout $QPID_CPP_VERSION
fi
export GCCFLAGS="-Wno-implicit-fallthrough -Wno-maybe-uninitialized"
cmake -DBUILD_BINDING_RUBY=OFF -DBUILD_DOCS=OFF -DBUILD_TESTING=OFF "-DCMAKE_CXX_FLAGS=$GCCFLAGS" -DCMAKE_INSTALL_PREFIX=/usr .
make
make install
rm -f /usr/lib64/qpid/daemon/store.so
cd $home
#
# Build and install python qpid bits
#
git clone git://git.apache.org/qpid-python.git
cd qpid-python
if [ "$VERSION" = "latest" ]; then
  git checkout $QPID_PYTHON_VERSION
fi
python setup.py install
#
# Remove build dependencies
#
dnf remove -y git gcc gcc-c++ cmake make swig pkgconfig libuuid-devel ${openssl}-devel python-devel python2-devel python3-devel cyrus-sasl-devel \
boost-devel boost-filesystem boost-program-options libaio-devel libdb4-cxx-devel libibverbs-devel librdmacm-devel nspr-devel nss-devel pkgconfig python-setuptools xerces-c-devel xqilla-devel
#
# Install run time dependencies
#
dnf install -y python ${openssl} boost-filesystem boost-program-options boost-system libaio libuuid cyrus-sasl xqilla xerces-c libdb4 libdb4-cxx python-saslwrapper
cd $home
#
# Cleanup
#
rm -fr qpid-proton qpid-cpp qpid-python
dnf clean all
exit
