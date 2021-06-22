# TCR sequencing
- This is the workflow of TCR sequencing and analysis for tumor TCR repertoire contraction/oligoclonality study. 
- Raw sequencing datas (fastq files) were processed through MiXCR for clonotype observation and analyzed with Immunarch as well as VDJviz


## Pipeline workflow

## Environments
- MiXCR v3.0.13
- Python v3.6.13
- Snakemake v5.7.0

## Input data
- Paired-end fastq files obtained from 5’RACE TCR sequencing [TAKARA SMARTer](https://www.takarabio.com/learning-centers/next-generation-sequencing/technical-notes/immune-profiling/tcr-repertoire-profiling-from-human-samples-(bulk))
- Bulk datas were obtained from B6 mice(CTRL/tumor-treated groups)

## Output data
-  txt files

## Run Snakefile
Run **Snakefile** by ```snakemake -p -j 20```

## Download sample.txt file from Linux to desktop
Navigate to desktop's local terminal and enter the following scp line at command.
```
$scp LinuxUserName@avisIP:[sample.txt file path] ~/Desktop/
```

## References
MiXCR Documantation
- https://mixcr.readthedocs.io/en/master/quickstart.html

Immunarch Documentation
- https://immunarch.com/
