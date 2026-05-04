configfile: "config/raw.yaml"
include: "workflows/raw.smk"

configfile: "config/cleaned.yaml"
include: "workflows/cleaned.smk"

configfile: "config/stats.yaml"
include: "workflows/stats.smk"

rule all:
    input:
        "results/stats/core-diversity",
        "results/stats/taxa-barplot.qzv"
