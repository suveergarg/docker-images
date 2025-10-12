FROM borglab/gtsam-ci:ubuntu-24.04-base
ARG COMPILER_VERSION=14

RUN apt-get -y install  g++-${COMPILER_VERSION} \
                        g++-${COMPILER_VERSION}-multilib \
                        binutils-gold

ENV CC="gcc-${COMPILER_VERSION}"
ENV CXX="g++-${COMPILER_VERSION}"
ENV LDFLAGS="-fuse-ld=gold"
ENV CMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold"
ENV CMAKE_SHARED_LINKER_FLAGS="-fuse-ld=gold"

# Build GTSAM and run tests
ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]