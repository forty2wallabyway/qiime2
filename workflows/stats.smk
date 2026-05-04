rule core_diversity:
    input:
        table="results/cleaned/table-no-organelle.qza",
        tree="results/cleaned/rooted-tree.qza",
        metadata=config["metadata"]
    output:
        directory("results/stats/core-diversity")
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime diversity core-metrics-phylogenetic \
          --i-table {input.table} \
          --i-phylogeny {input.tree} \
          --p-sampling-depth {config[sampling_depth]} \
          --m-metadata-file {input.metadata} \
          --output-dir {output}
        """

rule taxa_barplot:
    input:
        table="results/cleaned/table-no-organelle.qza",
        taxonomy="results/cleaned/taxonomy.qza",
        metadata=config["metadata"]
    output:
        "results/stats/taxa-barplot.qzv"
    conda:
        config["qiime2_env"]
    shell:
        """
        qiime taxa barplot \
          --i-table {input.table} \
          --i-taxonomy {input.taxonomy} \
          --m-metadata-file {input.metadata} \
          --o-visualization {output}
        """
