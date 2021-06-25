# Author: Tina Yang
# Date: Jun 23,2021
# TCRseq data analysis with Immunarch
# The script includes the following features:
  #1. Number of unique clonotypes
  #2. Clonotype abundances distribution
  #3. Repertoire overlap
  #4. Gene usage computation
  #5. Clonotypes tracking
  #6. Diversity estimation

setwd("~/Desktop/Joey Lab/Immunarch exercise")
library(immunarch)
# Import sample.txt obtained from MiXCR and metadata.txt
file_path = "~/Desktop/Joey Lab/Immunarch exercise/Data"
immdata_mixcr <- repLoad(file_path)
immdata_mixcr$data$`1418-LN-TCR-a` # Take a look at the data


##### Clonotypes Information #####
### Number of unique clonotypes
# Grouping by using .by and .meta
exp_vol <- repExplore(immdata_mixcr$data, .method = "volume")
Cnumber <- vis(exp_vol, .by = c("Sample"), .meta = immdata_mixcr$meta)
Cnumber
# basic exploratory analysis
p1 <- vis(exp_vol)
p1
# or analyse based on alpha / beta chain
exp_vol_a <- repExplore(immdata_mixcr$data[c(1,3,5,7)], .method = "volume")
Cnumber_a <- vis(exp_vol_a, .by = c("Sample"), .meta = immdata_mixcr$meta)
Cnumber_a

### Clonotype abundances distribution
exp_cnt <- repExplore(immdata_mixcr$data, .method = "count")
Dclonotypes <- vis(exp_cnt, .by = "Sample", .meta = immdata_mixcr$meta)
Dclonotypes
# or group by chain
Dclonotypes_chain <- vis(exp_cnt, .by = "Chain", .meta = immdata_mixcr$meta)


##### Repertoire overlap #####
imm_ov1 <- repOverlap(immdata_mixcr$data, .method = "public", .verbose = F)
vis(imm_ov1, "heatmap2")


##### Gene usage computation #####
gene_stats()
# Compute the distribution (normalized)
# Comparing 1418-LN vs SP (filters out all clonotypes with ambiguous gene alignments)
# Use TRAV genes of Mus Musculus as input 
imm_gu_trav <- geneUsage(immdata_mixcr$data[c(1,3)], "musmus.trav", .ambig = "exc", .norm = T)
vis(imm_gu_trav)
# Use TRAJ genes of Mus Musculus as input 
imm_gu_traj <- geneUsage(immdata_mixcr$data[c(1,3)], "musmus.traj", .ambig = "exc", .norm = T)
vis(imm_gu_traj)

##### Clonotypes tracking #####
# Finding most abundant clonotypes of TCR-alpha
# To choose the 10 most abundant aa clonotype sequences and their V +J gene segments from the “6973-LN-TCR-b” repertoire to track
tc <- trackClonotypes(immdata_mixcr$data[c(2,4,6,8)], list("6973-LN-TCR-b", 15), .col = "aa+v+j")
vis(tc, .plot = "smooth") + scale_fill_brewer(palette = "Spectral")


##### Sample Diversity estimation #####
### Hill numbers of beta-chain
div_hill_b <- repDiversity(immdata_mixcr$data[c(2,4,6,8)], "hill")
vis(div_hill_b, .meta = immdata_mixcr$meta)

### True diversity (effective number of types) of beta-chain
div_div_b <- repDiversity(immdata_mixcr$data[c(2,4,6,8)], "div")
vis(div_div_b)

### Chao1 diversity of beta-chain
div_chao_b <- repDiversity(immdata_mixcr$data[c(2,4,6,8)], "chao1")
vis(div_chao_b)
