class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s__p_e
label: VIRTUS.SE
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: genomeDir_human
    type: Directory
    'sbg:x': -305
    'sbg:y': -602
  - id: outFileNamePrefix_human
    type: string?
    'sbg:x': -317.6976318359375
    'sbg:y': -741.7814331054688
  - id: nthreads
    type: int?
    'sbg:x': -366.3414611816406
    'sbg:y': 303.09088134765625
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 417.4296875
    'sbg:y': 452.7935791015625
  - id: salmon_index_human
    type: Directory
    'sbg:x': -313.94915771484375
    'sbg:y': -922.5796508789062
  - id: salmon_quantdir_human
    type: string
    'sbg:x': -314.884765625
    'sbg:y': -1090
  - id: fastq
    type: File
    'sbg:x': -433.9359130859375
    'sbg:y': -313.2906188964844
outputs:
  - id: output_unmapped
    outputSource:
      - samtools_view/output
    type: File
    'sbg:x': 412
    'sbg:y': 218
  - id: output_fq2
    outputSource:
      - bedtools_bamtofastq_pe/output_fq2
    type: File?
    'sbg:x': 549.3675537109375
    'sbg:y': -334.5509948730469
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
    'sbg:x': 967.612548828125
    'sbg:y': 645.0413208007812
  - id: mappingstats_virus
    outputSource:
      - star_mapping_pe_virus/mappingstats
    type: File?
    'sbg:x': 956.122802734375
    'sbg:y': 39.143333435058594
  - id: output
    outputSource:
      - mk_summary_virus_count/output
    type: File?
    'sbg:x': 1280.2369384765625
    'sbg:y': -573.7061767578125
  - id: aligned_bam_human
    outputSource:
      - star_mapping_se/aligned
    type: File
    'sbg:x': 197.3414306640625
    'sbg:y': -108.84769439697266
  - id: Log.out_human
    outputSource:
      - star_mapping_se/Log.out
    type: File?
    'sbg:x': 276.6431579589844
    'sbg:y': -230.89942932128906
  - id: mappingstats_human
    outputSource:
      - star_mapping_se/mappingstats
    type: File?
    'sbg:x': 262.7428894042969
    'sbg:y': -369.5159912109375
  - id: SJ.out.tab_human
    outputSource:
      - star_mapping_se/SJ.out.tab
    type: File?
    'sbg:x': 240.66200256347656
    'sbg:y': -499.92999267578125
  - id: output_quantdir_human
    outputSource:
      - salmon_quant_se/output_quantdir
    type: Directory
    'sbg:x': 241.95457458496094
    'sbg:y': -672.1799926757812
steps:
  - id: samtools_view
    in:
      - id: threads
        source: nthreads
      - id: b
        default: true
      - id: f
        default: 4
      - id: prefix
        default: human
      - id: bam
        source: star_mapping_se/aligned
    out:
      - id: output
    run: ../tool/samtools/samtools-view.cwl
    label: samtools-view
    'sbg:x': 199.102294921875
    'sbg:y': 52.59203338623047
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
    'sbg:x': 406.1430358886719
    'sbg:y': 28.673505783081055
  - id: star_mapping_pe_virus
    in:
      - id: fq1
        source: bedtools_bamtofastq_pe/output_fq1
      - id: fq2
        source: bedtools_bamtofastq_pe/output_fq2
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
    'sbg:x': 681.9188232421875
    'sbg:y': 132.9390411376953
  - id: mk_virus_count
    in:
      - id: virus_bam
        source: star_mapping_pe_virus/aligned
    out:
      - id: virus_count
    run: ../tool/mk_virus_count.cwl
    label: mk_virus_count
    'sbg:x': 963.22509765625
    'sbg:y': 479.8780822753906
  - id: mk_summary_virus_count
    in:
      - id: input_STARLog
        source: star_mapping_se/mappingstats
      - id: input_virus_count
        source: mk_virus_count/virus_count
    out:
      - id: output
    run: ../tool/mk_summary_virus_count/mk_summary_virus_count.cwl
    label: mk_summary_virus_count
    'sbg:x': 1132.9288330078125
    'sbg:y': -576.298583984375
  - id: fastp_se
    in:
      - id: fastq
        source: fastq
      - id: threads
        source: nthreads
    out:
      - id: out_fastq
    run: ../tool/fastp/fastp-se.cwl
    'sbg:x': -266.3377380371094
    'sbg:y': -332.6100769042969
  - id: star_mapping_se
    in:
      - id: fq
        source: fastp_se/out_fastq
      - id: genomeDir
        source: genomeDir_human
      - id: nthreads
        source: nthreads
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
    run: ../tool/star/star_mapping-se/star_mapping-se.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': 7.433086395263672
    'sbg:y': -424.0473327636719
  - id: salmon_quant_se
    in:
      - id: index
        source: salmon_index_human
      - id: inf
        source: fastp_se/out_fastq
      - id: libType
        default: A
      - id: quantdir
        default: salmon_quantdir_human
        source: salmon_quantdir_human
      - id: runThreadN
        source: nthreads
      - id: gcBias
        default: true
      - id: validateMappings
        default: true
    out:
      - id: output_quantdir
    run: ../tool/salmon-cwl/salmon-quant_se.cwl
    'sbg:x': -10.507709503173828
    'sbg:y': -671.244873046875
requirements: []
'sbg:links':
  - id: 'https://github.com/yyoshiaki/VIRTUS'
    label: ''
