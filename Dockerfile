ARG AARCH=arm32v7
FROM ${AARCH}/ubuntu
RUN apt-get install build-essential cmake --no-install-recommends
WORKDIR /build
