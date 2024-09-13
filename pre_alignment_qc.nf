params.reads_se_unchanged = "raw_data/fastq/*.fastq.gz"
params.reads_pe = "raw_data/fastq/SRR*_{1,2}.fastq.gz"
params.adapfile = "/Users/rashmirao/Documents/Sidra_Externship/nextflow/RNA_seq_analysis_pc_version/raw_data/fastq/adapters.fa"


include { fastqc as fastqc1 } from './modules/fastqc'
include { fastqc as fastqc2 } from './modules/fastqc'
include { cutadapt } from './modules/cutadapt'
include { trimmomatic } from './modules/trimmomatic'
include {fastp} from './modules/fastp'


workflow pre_alignment_qc{
    
    read_ch1 = Channel.fromPath(params.reads_se_unchanged).ifEmpty { error "Cannot find any reads: ${params.reads_se_unchanged}" } 
    fastqc1(read_ch1)
    read_pairs_ch1 = Channel.fromFilePairs(params.reads_pe).ifEmpty { error "Cannot find any reads: ${params.reads_pe}" }.map { pair -> pair[1] }.view()
    output_cutadapt = cutadapt(read_pairs_ch1)
    output_trimmomatic = trimmomatic(output_cutadapt)
    output_fastp = fastp(output_trimmomatic)
    //read_ch2 = Channel.fromFilePairs(params.reads_se_changed).ifEmpty { error "Cannot find any reads: ${params.reads_se_changed}" }.map { pair -> pair[1] }.view()
    fastqc2(output_fastp)
}