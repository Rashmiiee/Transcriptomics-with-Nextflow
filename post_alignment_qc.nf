//qualimap, fastqc

params.reads_bam = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_star/*.out.bam"
params.gtffile = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/S288C_reference_genome_R64-5-1_20240529/yeast.gtf"

include { fastqc } from './modules/fastqc'
include { qualimap } from './modules/qualimap'


workflow post_alignment_qc{
    reads_bam = Channel.fromPath(params.reads_bam).ifEmpty { error "Cannot find any reads: ${params.reads_bam}" }
    qualimap(reads_bam)
    fastqc(reads_bam)
}