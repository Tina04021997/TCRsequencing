# Author: Tina Yang
# Date: Jun 18, 2021
# TCR sequencing for PE reads (data obtained using 5’RACE-based amplification protocols):
    # Quality control: FastQC + MultiQC
    # Alignment: MiXCR
    # Assemble Clones: MiXCR
    # Export: MiXCR
 
 SAMPLES, = glob_wildcards("/LVM_data/tina/TCR0511/data/{sample}_L001_R1_001.fastq.gz")
mixcr = "~/mixcr-3.0.13/mixcr"

for sample in SAMPLES:
        print("Sample " + sample + " will be processed...")

rule all:
    input:
        expand(["results/{sample}.txt"], sample = SAMPLES)

#Step1: Perform FastQC
rule fastqc:
     input:
         expand(["data/{sample}_L001_R1_001.fastq.gz","data/{sample}_L001_R2_001.fastq.gz"], sample = SAMPLES)
     output:
         "qc/fastqc/{sample}_L001_R1_001_fastqc.html",
         "qc/fastqc/{sample}_L001_R2_001_fastqc.html",
         "qc/fastqc/{sample}_L001_R1_001_fastqc.zip",
         "qc/fastqc/{sample}_L001_R2_001_fastqc.zip"
     log:
         "logs/fastqc/{sample}.log"
     threads: 1
     params:
        prefix = "{sample}"
     message:
        "...Now performing fastqc on {params.prefix}..."
     shell:
         "fastqc {input} -o qc/fastqc"

#Step2: Perform MultiQC
rule multiqc:
    input:
        expand(["qc/fastqc/{sample}_L001_R1_001_fastqc.html","qc/fastqc/{sample}_L001_R2_001_fastqc.html"], sample = SAMPLES),
        expand(["qc/fastqc/{sample}_L001_R1_001_fastqc.zip","qc/fastqc/{sample}_L001_R2_001_fastqc.zip"], sample = SAMPLES)
    output:
        "qc/multiqc/multiqc_report.html"
    log:
        "logs/multiqc/multiqc.log"
    threads: 1
    params:
        prefix = "{sample}"
    message:
        "...Now performing multiqc on {params.prefix}..."
    shell:
        "multiqc {input} -o qc/multiqc"

#Step3: Alignment 
#Align raw sequences to ref sequences of segments (V, D, J) of IGH gene with MiXCR
rule align:
    input:
        R1 = "/LVM_data/tina/TCR0511/data/{sample}_L001_R1_001.fastq.gz",
        R2 = "/LVM_data/tina/TCR0511/data/{sample}_L001_R2_001.fastq.gz"
    output:
        vdjca = "vdjca/{sample}.vdjca",
        report = "vdjca/{sample}.align.txt"
    threads: 20
    params:
        prefix = "{sample}"
    message:
        "...Now Aligning {params.prefix}..."
    shell:
        "{mixcr} align -s mmu -t {threads} -r {output.report} {input.R1} {input.R2} {output.vdjca}"
        
#Step4: Assemble Clones
#Build clonotypes from alignments obtained with align (Clonotyoe assemble based on CDR3 feature)
rule assemble:
    input:
        "vdjca/{sample}.vdjca"
    output:
        clna = "clna/{sample}.clna",
        report = "clna/{sample}.assemble.txt"
    threads: 20
    params:
        prefix = "{sample}"
    message:
        "...Now Assembling {params.prefix}..."
    shell:
        "{mixcr} assemble -t {threads} -a -r {output.report} {input} {output.clna}"

#Step5: Assemble full TCR
#Assemble full TCR receptor sequences
rule assembleContigs:
    input:
        "clna/{sample}.clna"
    output:
        clns = "clns/{sample}.clns",
        report = "clns/{sample}.assembleContigs.txt"
    threads: 20
    params:
        prefix = "{sample}"
    message:
        "...Now Assembling full TCR of sample {params.prefix}..."
    shell:
        "{mixcr} assembleContigs -t {threads} -r {output.report} {input} {output.clns}"

#Step6: Export
#Export alignment clones report from a binary file (.clns) to human readable txt file
rule export:
    input:
        "clns/{sample}.clns"
    output:
        "results/{sample}.txt"
    threads: 20
    params:
        prefix = "{sample}"
    message:
        "...Now Exporting {params.prefix}..."
    shell:
        "{mixcr} exportClones {input} {output}"
