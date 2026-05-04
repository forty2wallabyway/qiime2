rule import_data:
    input:
        "samples.tsv"
    output:
        "results/raw/demux.qza"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime tools import \
          --type 'SampleData[PairedEndSequencesWithQuality]' \
          --input-path samples.tsv \
          --input-format PairedEndFastqManifestPhred33V2 \
          --output-path {output}
        """

rule summarize_raw:
    input:
        "results/raw/demux.qza"
    output:
        "results/raw/demux-summary.qzv"
    conda:
        config["qiime2_env"]
    shell:
        "qiime demux summarize --i-data {input} --o-visualization {output}"

rule trim_primers:
    input:
        "results/raw/demux.qza"
    output:
        "results/raw/demux-trimmed.qza"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime cutadapt trim-paired \
          --i-demultiplexed-sequences {input} \
          --p-front-f {config[primers][forward]} \
          --p-front-r {config[primers][reverse]} \
          --p-discard-untrimmed \
          --o-trimmed-sequences {output}
        """
