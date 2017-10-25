# docker-qpid-cpp-broker

Docker image for Apache Qpid C++ broker. The image is based on fedora:latest.
Customize container execution using env variables.

## Building images

Build arguments:
  version, proton, cpp, pythonqpid and datadir. 

  version has 2 values:

  - latest (default), builds an image from latest released tags for qpid proton and
    and qpid cpp git source

  - devel, builds an image from branch master for qpid proton and qpid cpp 
    git source, you may need to change the build script to account for recent
    changes

  proton, cpp and pythonqpid values are tags for released versions of qpid proton, qpid cpp and python qpid
  in the git source (defaults are 0.18.0, 1.36.0 and 1.36.0 respectively).

  datadir value is used to set env QPID_DATA_DIR and volume (defaults to /var/lib/qpid_data).
  If QPID_DATA_DIR value is redefined at run time, it does not affect volume definition created during build,
  therefore the user also should define a new volume for data to persist.

Examples:

Build the image using latest released versions of proton and cpp (defined by Dockerfile):
  - docker build -t irinabov/docker-qpid-cpp-broker . | tee build-latest.log

Build the image using snapshot of upstream code:
  - docker build --build-arg version=devel -t irinabov/docker-qpid-cpp-broker:devel . | tee build-devel.log
  
Build the image using latest released versions of proton and cpp (defined by build arguments):
 - docker build --build-arg proton=0.18.0 -t irinabov/docker-qpid-cpp-broker . | tee build-latest.log

## Using the image

Examples:

Get help:
  - docker run --rm -p 5672:5672 irinabov/docker-qpid-cpp-broker --help

Customize container execution using env variables:
  - add QPID_ to any option shown above, use capital letters and replace dashes with underscores.

For example, run docker as a daemon, change tcp port in a test container:
  - docker run -d -p 6000:6000 -e QPID_PORT=6000 --name test irinabov/docker-qpid-cpp-broker

Use tools:
  - docker exec -it qpid-stat --help
  - docker exec -it test qpid-config --help
  - docker exec -it test qpid-config add queue foo --durable
  - docker exec -it test qpid-config del queue foo
