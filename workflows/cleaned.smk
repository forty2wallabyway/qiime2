rule dada2:
    input:
        "results/raw/demux-trimmed.qza"
    output:
        table="results/cleaned/table.qza",
        repseqs="results/cleaned/rep-seqs.qza"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime dada2 denoise-paired \
          --i-demultiplexed-seqs {input} \
          --p-trunc-len-f {config[dada2][trunc_len_f]} \
          --p-trunc-len-r {config[dada2][trunc_len_r]} \
          --p-n-threads {config[dada2][threads]} \
          --o-table {output.table} \
          --o-representative-sequences {output.repseqs}
        """

rule phylogeny:
    input:
        "results/cleaned/rep-seqs.qza"
    output:
        "results/cleaned/rooted-tree.qza"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime phylogeny align-to-tree-mafft-fasttree \
          --i-sequences {input} \
          --o-rooted-tree {output}
        """

rule taxonomy:
    input:
        "results/cleaned/rep-seqs.qza"
    output:
        "results/cleaned/taxonomy.qza"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime feature-classifier classify-sklearn \
          --i-classifier {config[classifier]} \
          --i-reads {input} \
          --o-classification {output}
        """

rule filter_organelle:
    input:
        table="results/cleaned/table.qza",
        taxonomy="results/cleaned/taxonomy.qza"
    output:
        "results/cleaned/table-no-organelle.qza"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime taxa filter-table \
          --i-table {input.table} \
          --i-taxonomy {input.taxonomy} \
          --p-exclude mitochondria,chloroplast \
          --o-filtered-table {output}
        """
