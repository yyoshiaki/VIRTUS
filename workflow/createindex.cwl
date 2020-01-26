class: Workflow
cwlVersion: v1.0
id: createindex
label: CreateIndex
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: dir_name_virus
    type: string
    'sbg:x': -696
    'sbg:y': -281
  - id: runThreadN
    type: int?
    'sbg:x': -689
    'sbg:y': 27
  - id: url_genomefasta_virus
    type: string
    'sbg:x': -682
    'sbg:y': -595
  - id: output_name_genomefasta_virus
    type: string
    'sbg:x': -688
    'sbg:y': -435
outputs:
  - id: starIndex
    outputSource:
      - star_index_virus/starIndex
    type: Directory
    'sbg:x': -165.3968505859375
    'sbg:y': -398
  - id: downloaded_genomefasta
    outputSource:
      - star_index_virus/downloaded_genomefasta
    type: File
    'sbg:x': -142
    'sbg:y': -155
steps:
  - id: star_index_virus
    in:
      - id: runThreadN
        source: runThreadN
      - id: url_genomefasta
        source: url_genomefasta_virus
      - id: output_name_genomefasta
        source: output_name_genomefasta_virus
      - id: dir_name
        source: dir_name_virus
    out:
      - id: downloaded_genomefasta
      - id: starIndex
    run: rnaseq-star_index/rnaseq-star_index.cwl
    'sbg:x': -448
    'sbg:y': -256
requirements:
  - class: SubworkflowFeatureRequirement
