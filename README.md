# TCR sequencing
This is the workflow for TCR sequencing and analysis aimed at tumor TCR repertoire contraction/oligoclonality study. Datas were obtained from B6 mice(CTRL/tumor-treated groups).  
## Pipeline workflow

## Environments
- MiXCR v3.0.13
- Python v3.6.13
- Snakemake v5.7.0

## Input data
- Paired-end fastq files obtained from 5’RACE TCR sequencing [TAKARA SMARTer](https://www.takarabio.com/learning-centers/next-generation-sequencing/technical-notes/immune-profiling/tcr-repertoire-profiling-from-human-samples-(bulk))
## Output data
-  txt files

## Run Snakefile
Run **Snakefile** by ```snakemake -p -j 20```

## References
MiXCR Documantation
- https://mixcr.readthedocs.io/en/master/quickstart.html

Immunarch Documentation
- https://immunarch.com/
