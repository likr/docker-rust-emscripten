FROM ubuntu

RUN apt-get update
RUN apt-get -y install curl python git cmake g++
RUN curl -O https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
RUN tar -xzf emsdk-portable.tar.gz
ENV PATH /emsdk_portable:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV EM_CONFIG /root/.emscripten
RUN emsdk update
RUN emsdk install sdk-incoming-64bit
RUN emsdk activate sdk-incoming-64bit
RUN git clone git://github.com/brson/rust
RUN cd rust && git reset origin/emscripten --hard && git submodule init && git submodule update; exit 0
RUN cd rust/src/llvm && git remote add kripken https://github.com/kripken/emscripten-fastcomp && git fetch origin && git fetch kripken
ENV PATH /emsdk_portable:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/emsdk_portable/clang/fastcomp/build_incoming_64/bin:/emsdk_portable/node/4.1.1_64bit/bin:/emsdk_portable/emscripten/incoming
RUN apt-get -y install default-jre
RUN cd rust && ./configure --target=asmjs-unknown-emscripten && make
RUN cd rust && make install
WORKDIR /work
