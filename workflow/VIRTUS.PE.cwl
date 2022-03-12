#!/usr/bin/env cwltool

class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s_p_e
doc: VIRTUS v2.0
label: VIRTUS.PE
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastq2
    type: File
    'sbg:x': -438
    'sbg:y': -427
  - id: fastq1
    type: File
    'sbg:x': -445.51458740234375
    'sbg:y': -274.6721496582031
  - id: genomeDir_human
    type: Directory
    'sbg:x': -305
    'sbg:y': -602
  - id: outFileNamePrefix_human
    type: string?
    'sbg:x': -304
    'sbg:y': -750
  - id: nthreads
    type: int?
    'sbg:x': -386.4197082519531
    'sbg:y': 242.87530517578125
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 417.4296875
    'sbg:y': 452.7935791015625
  - id: kz_threshold
    type: float?
    doc: 'default : 0.1'
    'sbg:x': -296.2785949707031
    'sbg:y': 411.1441650390625
  - id: filename_output
    type: string?
    doc: 'default : VIRTUS.output.tsv'
    'sbg:x': 886.1015625
    'sbg:y': -546
outputs:
  - id: Log.out_human
    outputSource:
      - star_mapping_pe_human/Log.out
    type: File?
    'sbg:x': 201
    'sbg:y': -114
  - id: Log.progress.out_human
    outputSource:
      - star_mapping_pe_human/Log.progress.out
    type: File?
    'sbg:x': 203
    'sbg:y': -268
  - id: SJ.out.tab_human
    outputSource:
      - star_mapping_pe_human/SJ.out.tab
    type: File?
    'sbg:x': 206
    'sbg:y': -521.0446166992188
  - id: aligned_bam_human
    outputSource:
      - star_mapping_pe_human/aligned
    type: File
    'sbg:x': 190.84915161132812
    'sbg:y': 381.26885986328125
  - id: output_unmapped
    outputSource:
      - samtools_view/output
    type: File
    'sbg:x': 340.177001953125
    'sbg:y': 225.9409942626953
  - id: output_fq2
    outputSource:
      - bedtools_bamtofastq_pe/output_fq2
    type: File?
    'sbg:x': 558.2530517578125
    'sbg:y': -337.0843505859375
  - id: output_fq1
    outputSource:
      - bedtools_bamtofastq_pe/output_fq1
    type: File
    'sbg:x': 562.6327514648438
    'sbg:y': -168
  - id: SJ.out.tab_virus
    outputSource:
      - star_mapping_pe_virus/SJ.out.tab
    type: File?
    'sbg:x': 954.8983154296875
    'sbg:y': -110.67289733886719
  - id: Log.progress.out_virus
    outputSource:
      - star_mapping_pe_virus/Log.progress.out
    type: File?
    'sbg:x': 959.8370361328125
    'sbg:y': 193.0820770263672
  - id: Log.out_virus
    outputSource:
      - star_mapping_pe_virus/Log.out
    type: File?
    'sbg:x': 960.4492797851562
    'sbg:y': 331.1433410644531
  - id: aligned_virus
    outputSource:
      - star_mapping_pe_virus/aligned
    type: File
    'sbg:x': 862.1668090820312
    'sbg:y': 348.64471435546875
  - id: mappingstats_virus
    outputSource:
      - star_mapping_pe_virus/mappingstats
    type: File?
    'sbg:x': 956.122802734375
    'sbg:y': 39.143333435058594
  - id: mappingstats_human
    outputSource:
      - star_mapping_pe_human/mappingstats
    type: File?
    'sbg:x': 206.1626434326172
    'sbg:y': -394.3936767578125
  - id: aligned_bam_virus_filtered
    outputSource:
      - bam_filter_polyx/output
    type: File?
    'sbg:x': 984
    'sbg:y': 707
  - id: output_coverage
    outputSource:
      - samtools_coverage/output
    type: File
    'sbg:x': 1142.3587646484375
    'sbg:y': 520.5
  - id: output
    outputSource:
      - mk_summary_virus_count/output
    type: File?
    'sbg:x': 1276
    'sbg:y': -400
steps:
  - id: fastp_pe
    in:
      - id: fastq1
        source: fastq1
      - id: fastq2
        source: fastq2
      - id: threads
        source: nthreads
      - id: length
        default: 40
    out:
      - id: out_fastq1
      - id: out_fastq2
    run: ../tool/fastp/fastp-pe.cwl
    'sbg:x': -271.3704528808594
    'sbg:y': -358.8819885253906
  - id: star_mapping_pe_human
    in:
      - id: fq1
        source: fastp_pe/out_fastq1
      - id: fq2
        source: fastp_pe/out_fastq2
      - id: genomeDir
        source: genomeDir_human
      - id: nthreads
        source: nthreads
      - id: outSAMunmapped
        default: Within
      - id: outFileNamePrefix
        source: outFileNamePrefix_human
      - id: outSAMtype
        default: BAM SortedByCoordinate
    out:
      - id: aligned
      - id: bamRemDups
      - id: mappingstats
      - id: readspergene
      - id: transcriptomesam
      - id: Log.out
      - id: Log.progress.out
      - id: SJ.out.tab
      - id: unmapped
    run: ../tool/star/star_mapping-pe/star_mapping-pe.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': -29
    'sbg:y': -369
  - id: samtools_view
    in:
      - id: threads
        source: nthreads
      - id: f
        default: 4
      - id: prefix
        default: human
      - id: bam
        source: star_mapping_pe_human/aligned
    out:
      - id: output
    run: ../tool/samtools/samtools-view.cwl
    label: samtools-view
    'sbg:x': 179.7147216796875
    'sbg:y': 53.134429931640625
  - id: bedtools_bamtofastq_pe
    in:
      - id: input
        source: samtools_view/output
      - id: fq
        default: unmapped_1.fq
      - id: fq2
        default: unmapped_2.fq
    out:
      - id: output_fq1
      - id: output_fq2
    run: ../tool/bedtools/bedtools-bamtofastq-pe.cwl
    label: bedtools-bamtofastq-pe
    'sbg:x': 315.8917236328125
    'sbg:y': -33.99026870727539
  - id: star_mapping_pe_virus
    in:
      - id: fq1
        source: fastq_pair/fq1_paired
      - id: fq2
        source: fastq_pair/fq2_paired
      - id: genomeDir
        source: genomeDir_virus
      - id: nthreads
        source: nthreads
      - id: outFileNamePrefix
        default: virus
      - id: outSAMtype
        default: BAM SortedByCoordinate
    out:
      - id: aligned
      - id: bamRemDups
      - id: mappingstats
      - id: readspergene
      - id: transcriptomesam
      - id: Log.out
      - id: Log.progress.out
      - id: SJ.out.tab
      - id: unmapped
    run: ../tool/star/star_mapping-pe/star_mapping-pe.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': 753.9961547851562
    'sbg:y': 133.0281219482422
  - id: bam_filter_polyx
    in:
      - id: input
        source: star_mapping_pe_virus/aligned
    out:
      - id: output
    run: ../tool/samtools/bam_filter_polyx.cwl
    label: bam_filter_polyX
    'sbg:x': 825.17626953125
    'sbg:y': 513.4646606445312
  - id: kz_filter_fq2
    in:
      - id: threshold
        default: 0.1
        source: kz_threshold
      - id: input_fq
        source: bedtools_bamtofastq_pe/output_fq2
      - id: output_fq
        default: kz_2.fq
    out:
      - id: output
    run: ../tool/kz_filter/kz_filter.cwl
    label: kz-filter_fq2
    'sbg:x': 460.7408752441406
    'sbg:y': 27.032846450805664
  - id: kz_filter_fq1
    in:
      - id: threshold
        default: 0.1
        source: kz_threshold
      - id: input_fq
        source: bedtools_bamtofastq_pe/output_fq1
      - id: output_fq
        default: kz_1.fq
    out:
      - id: output
    run: ../tool/kz_filter/kz_filter.cwl
    label: kz-filter_fq1
    'sbg:x': 458
    'sbg:y': 155
  - id: fastq_pair
    in:
      - id: fq1
        source: kz_filter_fq1/output
      - id: fq2
        source: kz_filter_fq2/output
    out:
      - id: fq1_paired
      - id: fq2_paired
    run: ../tool/fastq_pair/fastq_pair.cwl
    label: fastq_pair
    'sbg:x': 577.2360229492188
    'sbg:y': 93.92456817626953
  - id: samtools_coverage
    in:
      - id: input
        source: bam_filter_polyx/output
    out:
      - id: output
    run: ../tool/samtools/samtools-coverage.cwl
    label: samtools-coverage
    'sbg:x': 960
    'sbg:y': 454
  - id: mk_summary_virus_count
    in:
      - id: input_STARLog
        source: star_mapping_pe_human/mappingstats
      - id: input_virus_cov
        source: samtools_coverage/output
      - id: input_layout
        default: PE
      - id: filename_output
        default: VIRTUS.output.tsv
        source: filename_output
    out:
      - id: output
    run: ../tool/mk_summary_virus_count/mk_summary_virus_count.cwl
    label: mk_summary_virus_count
    'sbg:x': 1087
    'sbg:y': -400
requirements: []
'sbg:license': CC BY-NC 4.0
'sbg:links':
  - id: 'https://github.com/yyoshiaki/VIRTUS2'
    label: ''
'sbg:toolAuthor': Yoshiaki Yasumizu
