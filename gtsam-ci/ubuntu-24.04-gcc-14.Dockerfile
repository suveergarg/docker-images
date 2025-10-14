FROM borglab/gtsam-ci:ubuntu-24.04-base

RUN apt-get -y install  g++-14 g++-14-multilib binutils-gold

ENV CC="gcc-14"
ENV CXX="g++-14"
ENV LDFLAGS="-fuse-ld=gold"
ENV CMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold"
ENV CMAKE_SHARED_LINKER_FLAGS="-fuse-ld=gold"

# Build GTSAM and run tests
ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]