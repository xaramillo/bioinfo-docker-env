#!/bin/bash

# Create and activate a new conda environment with bioinformatics tools
/opt/conda/bin/conda create -n bioinfo -y python=3.8 && \
echo "source activate bioinfo" > ~/.bashrc

# Install common bioinformatics tools
/opt/conda/bin/conda install -n bioinfo -c bioconda fastqc bwa samtools
