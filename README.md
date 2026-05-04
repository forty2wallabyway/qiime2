# QIIME2

### In development - Will be used to automate processing of Illumina reads generated from 515F and 806R 16S libraries using Qiime2 tools. 

#### To run full pipline:
`snakemake --use-conda --cores 16`

#### To run only raw processing:
`snakemake results/raw/demux-trimmed.qza --use-conda`

### To rerun stats with a new depth:
`vim config/stats.yaml
snakemake results/stats/core-diversity --use-conda`
