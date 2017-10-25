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
      version="$VERSION" \
      version-usage="version has 2 values: latest (released proton $QPID_PROTON_VERSION, cpp $QPID_CPP_VERSION and $QPID_PYTHON_VERSION) or devel (under development)" \
      usage="docker run -d -p 5672:5672 irinabov/docker-qpid-cpp-broker" \
      usage1="This container is using $QPID_DATA_DIR volume to save data" \
      usage2="docker run -d -p 5672:5672 --name test irinabov/docker-qpid-cpp-broker" \
      usage3="docker run -p 5672:5672 irinabov/docker-qpid-cpp-broker --help" \
      usage4="Customize container execution using env variables: add QPID_ to any option shown above, use capital letters and replace dashes with underscores." \
      example1="For example, change tcp port: docker run -d -p 5672:6000 -e QPID_PORT=6000 --name test irinabov/docker-qpid-cpp-broker" \
      usage5="Use tools:" \
      example2="For example, docker exec -it qpid-stat --help"

# Install all dependencies, build from source, install qpid-cpp components
COPY ./build.sh  /
RUN ./build.sh

VOLUME ${QPID_DATA_DIR}
EXPOSE 5671 5672
ENTRYPOINT ["/usr/sbin/qpidd"]
