# ============================================================
# Dockerfile — STM32F4xx HAL Driver Doxygen Documentation
# ============================================================
# Clones the STMicroelectronics stm32f4xx-hal-driver repo and
# generates HTML + LaTeX documentation with Doxygen.
# The generated docs are placed in /docs/output inside the image
# and can be exported via a named volume or bind-mount.
# ============================================================

FROM ubuntu:22.04

# ---------- Build arguments ----------
ARG REPO_URL=https://github.com/STMicroelectronics/stm32f4xx-hal-driver.git
ARG REPO_BRANCH=master
ARG DOCS_OUTPUT_DIR=/docs/output

# ---------- Environment ----------
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC

# ---------- System dependencies ----------
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        doxygen \
        graphviz \
        # Required by Doxygen PDF generation (optional – remove if not needed)
        texlive-latex-base \
        texlive-fonts-recommended \
        make \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ---------- Clone the HAL driver source ----------
WORKDIR /src
RUN git clone --depth 1 --branch ${REPO_BRANCH} ${REPO_URL} hal-driver

# ---------- Copy Doxyfile into the image ----------
# The Doxyfile is embedded via a heredoc so the image is self-contained.
# Adjust any setting below to suit your needs.
COPY Doxyfile /src/Doxyfile

# ---------- Run Doxygen ----------
RUN mkdir -p ${DOCS_OUTPUT_DIR} \
    && doxygen /src/Doxyfile

# ---------- Default command ----------
# When run interactively the container prints where the docs landed.
CMD ["sh", "-c", "echo 'Doxygen build complete. Docs are in ${DOCS_OUTPUT_DIR}'"]
