FROM borglab/gtsam-ci:ubuntu-22.04-base
ARG COMPILER_VERSION=11

# Install clang
# (ipv4|ha).pool.sks-keyservers.net is the SKS GPG global keyserver pool
# ipv4 avoids potential timeouts because of crappy IPv6 infrastructure
# 15CF4D18AF4F7421 is the GPG key for the LLVM apt repository
# This key is not in the keystore by default for Ubuntu so we need to add it.
ARG LLVM_KEY=15CF4D18AF4F7421
RUN gpg --keyserver keyserver.ubuntu.com --recv-key ${LLVM_KEY} || gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key ${LLVM_KEY}
RUN gpg -a --export ${LLVM_KEY} | apt-key add -
# LLVM (clang) 9/14 is not in Bionic's repositories so we add the official LLVM repository.
RUN add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main"
# LLVM (clang) 9/14 is not in 22.04 (jammy)'s repositories so we add the official LLVM repository.
RUN add-apt-repository "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main"

RUN apt-get update
RUN apt-get install -y clang-${COMPILER_VERSION} \
                        mold

ENV CC="clang-${COMPILER_VERSION}"
ENV CXX="clang++-${COMPILER_VERSION}"
ENV LDFLAGS="-fuse-ld=mold"
ENV CMAKE_EXE_LINKER_FLAGS="-fuse-ld=mold"
ENV CMAKE_SHARED_LINKER_FLAGS="-fuse-ld=mold"

# Build GTSAM and run tests
ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]