class: Workflow
cwlVersion: v1.0
id: virtus_recount
label: VIRTUS.recount
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: virus_bam
    type: File
    'sbg:x': -689.3968505859375
    'sbg:y': -258
  - id: hit_cutoff
    type: int?
    'sbg:x': -688.3968505859375
    'sbg:y': -40
  - id: input_STARLog
    type: File
    'sbg:x': -683
    'sbg:y': 150
outputs:
  - id: output
    outputSource:
      - mk_summary_virus_count/output
    type: File?
    'sbg:x': -19.3968505859375
    'sbg:y': 36
steps:
  - id: mk_virus_count
    in:
      - id: virus_bam
        source: virus_bam
      - id: hit_cutoff
        source: hit_cutoff
    out:
      - id: virus_count
    run: ../tool/mk_virus_count.cwl
    label: mk_virus_count
    'sbg:x': -486
    'sbg:y': -139
  - id: mk_summary_virus_count
    in:
      - id: input_STARLog
        source: input_STARLog
      - id: input_virus_count
        source: mk_virus_count/virus_count
    out:
      - id: output
    run: ../tool/mk_summary_virus_count/mk_summary_virus_count.cwl
    label: mk_summary_virus_count
    'sbg:x': -282
    'sbg:y': 35
requirements: []
