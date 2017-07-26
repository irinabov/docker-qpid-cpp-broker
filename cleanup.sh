#!/bin/bash -ex

rm -fr qpid-proton qpid-cpp
dnf remove -y git $(cat proton_build_dependencies.txt) $(cat cpp_build_dependencies.txt) -x python3 -x cyrus-sasl-lib 
dnf install -y $(cat proton_run_dependencies.txt) $(cat cpp_run_dependencies.txt)

dnf clean all
exit
