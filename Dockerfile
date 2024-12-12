# Use an official Debian 12 as a parent image
FROM debian:12

# Set the maintainer label
LABEL maintainer="xaramillo"

# Avoid user interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    python3 \
    python3-pip \
    r-base \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Update PATH environment variable
ENV PATH /opt/conda/bin:$PATH

# Copy the Conda environment setup script
COPY setup_conda.sh /setup_conda.sh

# Run the Conda environment setup script
RUN bash /setup_conda.sh

# Install Bioconductor packages
RUN R -e "install.packages('BiocManager'); BiocManager::install(c('GenomicRanges', 'DESeq2'))"

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
