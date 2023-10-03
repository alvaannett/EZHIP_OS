library(vcfR)

args = commandArgs(trailingOnly = TRUE)
sample = args[1]
pipline_path = args[2]
out_path = args[3]


PATH=paste0(pipline_path, sample, '/variants/', sample, '.filterAnnotated.vcf.gz')

vcf = vcfR::read.vcfR(PATH, verbose = FALSE )
chrom = create.chromR(name=sample, vcf=vcf)
chrom = proc.chromR(chrom)

pdf(file = paste0(out_path, sample, '.pdf'))
plot(chrom)
chromoqc(chrom, dp.alpha=20)
dev.off()

write.vcf(vcf, paste0(out_path, sample, '.filterAnnotated.vcf.gz'))


