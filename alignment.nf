
params.reads2align = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/results/results_fastp/*_[12].fastq.gz"
params.genome_dir = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/S288C_reference_genome_R64-5-1_20240529/ref_genome_files/index"
params.gtffile = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/S288C_reference_genome_R64-5-1_20240529/yeast.gtf"
params.out_prefix ="out"
params.threads = 4

include {star} from './modules/star'

workflow alignment{

    read_pairs_ch = Channel.fromFilePairs(params.reads2align)
    .ifEmpty { error "Cannot find any reads: ${params.reads2align}" }
    .map { pair -> pair[1] }  // Extract only the list of file paths
    .view()
    // Run star
    star(read_pairs_ch)
}