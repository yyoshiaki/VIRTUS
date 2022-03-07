class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s__s_e
doc: VIRTUS v1.2.1
label: VIRTUS.SE
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: genomeDir_human
    type: Directory
    'sbg:x': -315
    'sbg:y': -603
  - id: outFileNamePrefix_human
    type: string?
    'sbg:x': -312
    'sbg:y': -754
  - id: nthreads
    type: int?
    'sbg:x': -366.3414611816406
    'sbg:y': 303.09088134765625
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
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 447.2225036621094
    'sbg:y': -263.0279846191406
  - id: hit_cutoff
    type: int?
    'sbg:x': 738.9225463867188
    'sbg:y': 519.65234375
  - id: kz_threshold
    type: float?
    doc: 'default : 0.1'
    'sbg:x': -254.75790405273438
    'sbg:y': 476.1842956542969
outputs:
  - id: output_unmapped
    outputSource:
      - samtools_view/output
    type: File
    'sbg:x': 412
    'sbg:y': 218
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
  - id: output_fq
    outputSource:
      - bedtools_bamtofastq_se/output_fq
    type: File
    'sbg:x': 605.4130859375
    'sbg:y': -62.6005744934082
  - id: SJ.out.tab_virus
    outputSource:
      - star_mapping_se_virus/SJ.out.tab
    type: File?
    'sbg:x': 848.7875366210938
    'sbg:y': -104.10987854003906
  - id: mappingstats_virus
    outputSource:
      - star_mapping_se_virus/mappingstats
    type: File?
    'sbg:x': 889.2903442382812
    'sbg:y': 25.706695556640625
  - id: Log.out_virus
    outputSource:
      - star_mapping_se_virus/Log.out
    type: File?
    'sbg:x': 907
    'sbg:y': 151
  - id: aligned_bam_virus
    outputSource:
      - star_mapping_se_virus/aligned
    type: File
    'sbg:x': 844.6334228515625
    'sbg:y': 646.7491455078125
  - id: output_coverage
    outputSource:
      - samtools_coverage/output
    type: File
    'sbg:x': 1118
    'sbg:y': 432
  - id: virus_count
    outputSource:
      - mk_virus_count/virus_count
    type: File
    'sbg:x': 1117
    'sbg:y': 604
steps:
  - id: samtools_view
    in:
      - id: threads
        source: nthreads
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
  - id: mk_virus_count
    in:
      - id: virus_bam
        source: bam_filter_polyx/output
      - id: hit_cutoff
        default: 400
        source: hit_cutoff
    out:
      - id: virus_count
    run: ../tool/mk_virus_count.cwl
    label: mk_virus_count
    'sbg:x': 962
    'sbg:y': 510
  - id: mk_summary_virus_count
    in:
      - id: input_STARLog
        source: star_mapping_se/mappingstats
      - id: input_virus_count
        source: mk_virus_count/virus_count
      - id: input_layout
        default: SE
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
      - id: length
        default: 40
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
  - id: bedtools_bamtofastq_se
    in:
      - id: input
        source: samtools_view/output
      - id: fq
        default: unmapped.fq
    out:
      - id: output_fq
    run: ../tool/bedtools/bedtools-bamtofastq-se.cwl
    label: bedtools-bamtofastq-pe
    'sbg:x': 350.34454345703125
    'sbg:y': -113.04795837402344
  - id: star_mapping_se_virus
    in:
      - id: fq
        source: kz_filter/output
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
    run: ../tool/star/star_mapping-se/star_mapping-se.cwl
    label: 'STAR mapping: running mapping jobs.'
    'sbg:x': 722.9669799804688
    'sbg:y': 137.9506378173828
  - id: bam_filter_polyx
    in:
      - id: input
        source: star_mapping_se_virus/aligned
    out:
      - id: output
    run: ../tool/samtools/bam_filter_polyx.cwl
    label: bam_filter_polyX
    'sbg:x': 847.6024780273438
    'sbg:y': 366.4100036621094
  - id: kz_filter
    in:
      - id: threshold
        default: 0.1
        source: kz_threshold
      - id: input_fq
        source: bedtools_bamtofastq_se/output_fq
      - id: output_fq
        default: kz.fq
    out:
      - id: output
    run: ../tool/kz_filter/kz_filter.cwl
    label: kz-filter
    'sbg:x': 489.5152893066406
    'sbg:y': 39.372711181640625
  - id: samtools_coverage
    in:
      - id: input
        source: bam_filter_polyx/output
    out:
      - id: output
    run: ../tool/samtools/samtools-coverage.cwl
    label: samtools-coverage
    'sbg:x': 963
    'sbg:y': 371
requirements: []
'sbg:license': CC BY-NC 4.0
'sbg:links':
  - id: 'https://github.com/yyoshiaki/VIRTUS'
    label: ''
'sbg:toolAuthor': Yoshiaki Yasumizu
