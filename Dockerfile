FROM fedora:latest
ARG version
ARG proton
ARG cpp
ARG pythonqpid
ARG datadir
ENV VERSION=${version:-latest} \
    NAME=docker-qpid-cpp-broker \
    QPID_PROTON_VERSION=${proton:-0.18.0} \
    QPID_CPP_VERSION=${cpp:-1.36.0} \
    QPID_PYTHON_VERSION=${pythonqpid:-1.36.0} \
    QPID_DATA_DIR=${datadir:-/var/lib/qpid_data}
LABEL maintainer="Irina Boverman <irina.boverman@gmail.com>" \
      summary="Docker image for Qpid C++ broker." \
      name="irinabov/$NAME" \
      version="$VERSION"

# Install all dependencies, build from source, install qpid-cpp components
COPY ./build.sh  /
RUN ./build.sh

VOLUME ${QPID_DATA_DIR}
EXPOSE 5671 5672
ENTRYPOINT ["/usr/sbin/qpidd"]
