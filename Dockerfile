FROM islasgeci/base:13fe

RUN git clone https://github.com/bats-core/bats-core.git && \
    cd bats-core && \
    ./install.sh /usr/local

RUN apt-get update && apt-get install --yes \
    docker.io
