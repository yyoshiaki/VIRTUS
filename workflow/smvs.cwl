class: Workflow
cwlVersion: v1.0
id: _v_i_r_t_u_s__s_e
doc: VIRTUS v1.0
label: smvs
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: nthreads
    type: int?
    'sbg:x': -109.26367950439453
    'sbg:y': 303
  - id: genomeDir_virus
    type: Directory
    'sbg:x': 447.2225036621094
    'sbg:y': -263.0279846191406
  - id: hit_cutoff
    type: int?
    'sbg:x': 738.9225463867188
    'sbg:y': 519.65234375
  - id: bam
    type: File
    'sbg:x': -106.00248718261719
    'sbg:y': 74.46144104003906
  - id: input_STARLog
    type: File
    'sbg:x': 876.682861328125
    'sbg:y': -559.8308715820312
outputs:
  - id: aligned_bam_virus
    outputSource:
      - star_mapping_se_virus/aligned
    type: File
    'sbg:x': 950
    'sbg:y': 666
  - id: aligned_bam_virus_filtered
    outputSource:
      - bam_filter_polyx/output
    type: File?
    'sbg:x': 949.710693359375
    'sbg:y': 282.77105712890625
  - id: out
    outputSource:
      - mv/out
    type: File
    'sbg:x': 1457
    'sbg:y': -580
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
        source: bam
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
    'sbg:x': 963.22509765625
    'sbg:y': 479.8780822753906
  - id: mk_summary_virus_count
    in:
      - id: input_STARLog
        source: input_STARLog
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
    'sbg:x': 392.1208801269531
    'sbg:y': -110.00155639648438
  - id: star_mapping_se_virus
    in:
      - id: fq
        source: bedtools_bamtofastq_se/output_fq
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
  - id: mv
    in:
      - id: infile
        source: mk_summary_virus_count/output
      - id: outfile
        default: virus.smv.tsv
    out:
      - id: out
    run: ../tool/mv/mv.cwl
    label: mv
    'sbg:x': 1288
    'sbg:y': -578
requirements: []
'sbg:license': CC BY-NC 4.0
'sbg:links':
  - id: 'https://github.com/yyoshiaki/VIRTUS'
    label: ''
'sbg:toolAuthor': Yoshiaki Yasumizu
