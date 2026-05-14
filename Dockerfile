# =========================
# Builder stage
# =========================
FROM alpine:latest AS builder

ARG DOXYGEN_REF=master

RUN apk add --no-cache \
    build-base \
    cmake \
    python3 \
    flex \
    bison \
    git

WORKDIR /src

# Clone official repository
RUN git clone --depth 1 \
    --branch ${DOXYGEN_REF} \
    https://github.com/doxygen/doxygen.git .

# Configure + build + install
RUN cmake -S . -B build \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/doxygen \
    && cmake --build build -j"$(nproc)" \
    && cmake --install build


# =========================
# Runtime stage
# =========================
FROM alpine:latest

RUN apk add --no-cache \
    git \
    graphviz \
    libstdc++

COPY --from=builder /opt/doxygen /opt/doxygen

ENV PATH="/opt/doxygen/bin:${PATH}"

WORKDIR /workspace

# This allows the container to run doxygen by default, 
# but makes it much easier to override with a shell script.
CMD ["doxygen"]
