# docker-qpid-cpp

Docker image for Apache Qpid C++ broker. The image is based on Fedora 26.
Apache Proton version is 0.17.0 and Qpid Cpp version is 1.36.0.

## Using the image

Examples:

Run docker as a daemon in a test container:
  docker run -d -p 5672:5672 --name test irinabov/docker-qpid-cpp

While this containter is running, look at qpidd options:
  docker exec -it test qpidd --help

Customize container execution using env variables: 
  add QPID_ to any option shown above, use capital letters and replace dashes with underscores.

For example, change tcp port and store directory:
  docker run -d -p 5672:6000 -e QPID_PORT=6000 -e QPID_DATA_DIR=/root/qpid_data -v /root/qpid_data:/root/qpid_data:Z --name test1 irinabov/docker-qpid-cpp
