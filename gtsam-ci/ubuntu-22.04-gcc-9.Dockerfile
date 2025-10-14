FROM borglab/gtsam-ci:ubuntu-22.04-base
ARG COMPILER_VERSION=9

RUN apt-get -y install  g++-9 g++-9-multilib binutils-gold

ENV CC="gcc-9"
ENV CXX="g++-9"
ENV LDFLAGS="-fuse-ld=gold"
ENV CMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold"
ENV CMAKE_SHARED_LINKER_FLAGS="-fuse-ld=gold"

# Build GTSAM and run tests
ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]