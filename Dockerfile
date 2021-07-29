FROM ubuntu:20.04
WORKDIR /workdir
COPY . .

RUN apt update && apt install --yes \
    curl \
    git \
    make

RUN curl --fail --location https://git.io/shellspec --show-error --silent | sh -s -- --yes
ENV PATH="/root/.local/lib/shellspec:$PATH"
RUN shellspec --init

