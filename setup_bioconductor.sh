#!/bin/bash
# Install Bioconductor and related R packages
R -e "install.packages('BiocManager', repos='http://cran.r-project.org'); \
      BiocManager::install(c('GenomicRanges', 'DESeq2'))"
