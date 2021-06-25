# TCR sequencing
- This is the workflow of TCR sequencing and analysis for tumor TCR repertoire contraction / oligoclonality study
- Raw sequencing datas were processed through MiXCR for clonotype observation and analyzed with Immunarch as well as [VDJviz](https://vdjviz.cdr3.net/)


## Pipeline workflow
Which includes:
1. QC test: FastQC + MultiQC
2. Alignment: MiXCR
3. Assemble Clones: MiXCR
4. Export txt files: MiXCR
5. Bulk TCR exploration (R Studio): Immunarch
6. Circos plot (VDJviz browser): VDJviz

<img src="https://github.com/Tina04021997/TCRsequencing/blob/main/TCRflow.jpg">

## Environments
- MiXCR v3.0.13
- Python v3.6.13
- Snakemake v5.7.0

## Input data
- Paired-end fastq files obtained from 5’RACE TCR sequencing [TAKARA SMARTer](https://www.takarabio.com/learning-centers/next-generation-sequencing/technical-notes/immune-profiling/tcr-repertoire-profiling-from-human-samples-(bulk)), total 16 fastq files
- Bulk datas were obtained from B6 mice(CTRL/tumor-treated groups)
- Metadata

| Sample  | Number | Tissue  | Chain | Type  | Source | Batch  | N |
| ------------- | :-------------: | :-------------: | :-------------: | :-----: | :-----: | :---: | :---: |
| 1418-LN-TCR-a  | 1418 | LN  | TCR-a  | Ctrl  | TGIA  | 1  | 5  |
| 1418-LN-TCR-b  | 1418 | LN  | TCR-b  | Ctrl  | TGIA  | 1  | 5  |
| 1418-SP-TCR-a  | 1418 | SP  | TCR-a  | Ctrl  | TGIA  | 1  | 5  |
| 1418-SP-TCR-b  | 1418 | SP  | TCR-b  | Ctrl  | TGIA  | 1  | 5  |
| 6973-LN-TCR-a  | 6973 | LN  | TCR-a  | MTCQ1  | TGIA  | 1  | 5  |
| 6973-LN-TCR-b  | 6973 | LN  | TCR-b  | MTCQ1  | TGIA  | 1  | 5  |
| 6973-SP-TCR-a  | 6973 | SP  | TCR-a  | MTCQ1  | TGIA  | 1  | 5  |
| 6973-SP-TCR-b  | 6973 | SP  | TCR-b  | MTCQ1  | TGIA  | 1  | 5  |

## Output data 
-  txt files

## Run Snakefile
Run **Snakefile** by ```snakemake -p -j 20```

## Download sample.txt file from Linux to desktop
Navigate to desktop's local terminal and enter the following command at command line:
```
$scp LinuxUserName@avisIP:sample.txt_file_path ~/Desktop/
```

## References
MiXCR Documantation
- https://mixcr.readthedocs.io/en/master/quickstart.html

Immunarch Documentation
- https://immunarch.com/

Load MiXCR files into Immunarch
- https://immunarch.com/articles/web_only/load_mixcr.html#loading-a-folder
