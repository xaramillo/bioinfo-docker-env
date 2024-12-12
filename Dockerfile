# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set the maintainer label
#LABEL maintainer="SolariaBiodata/Xaramillo"

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
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Update PATH environment variable
ENV PATH /opt/conda/bin:$PATH

# Create and activate a new conda environment with bioinformatics tools
RUN conda create -n bioinfo -y python=3.8 && \
    echo "source activate bioinfo" > ~/.bashrc

# Install common bioinformatics tools
RUN /bin/bash -c "source activate bioinfo && \
    conda install -c bioconda fastqc bwa samtools"

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
