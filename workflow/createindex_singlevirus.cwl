class: Workflow
cwlVersion: v1.0
id: createindex_singlevirus
label: createindex_singlevirus
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: dir_name
    type: string
    'sbg:x': -723
    'sbg:y': -122
  - id: runThreadN
    type: int?
    'sbg:x': -376.3968505859375
    'sbg:y': -525
  - id: genomeFastaFiles
    type: File
    'sbg:x': -564.734375
    'sbg:y': -338
outputs:
  - id: starIndex
    outputSource:
      - star_index/starIndex
    type: Directory
    'sbg:x': 36.765625
    'sbg:y': -256
steps:
  - id: star_index
    in:
      - id: genomeDir
        source: mkdir/created_directory
      - id: genomeFastaFiles
        source: genomeFastaFiles
      - id: runThreadN
        source: runThreadN
      - id: genomeSAindexNbases
        default: 10
    out:
      - id: starIndex
    run: ../tool/star/star_index/star_index.cwl
    label: 'STAR genomeGenerate: Generating genome indexes.'
    'sbg:x': -184
    'sbg:y': -256
  - id: mkdir
    in:
      - id: dir_name
        source: dir_name
    out:
      - id: created_directory
    run: ../tool/mkdir/mkdir.cwl
    label: Make directory if not exists
    'sbg:x': -548
    'sbg:y': -123
requirements: []
