class: Workflow
cwlVersion: v1.0
id: createindex_singlevirus
label: createindex_singlevirus
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: dir_name_STAR
    type: string
    'sbg:x': -723
    'sbg:y': -122
  - id: runThreadN
    type: int?
    'sbg:x': -566
    'sbg:y': -675
  - id: genomeFastaFiles
    type: File
    'sbg:x': -564.734375
    'sbg:y': -338
  - id: genomeSAindexNbases
    type: int?
    doc: 'For small genome such as single virus, this value need to be small.'
    'sbg:x': -563
    'sbg:y': -516
  - id: transcripts
    type: File
    'sbg:x': -570
    'sbg:y': 54
  - id: index_salmon
    type: string
    'sbg:x': -578
    'sbg:y': 216
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
        source: genomeSAindexNbases
    out:
      - id: starIndex
    run: ../tool/star/star_index/star_index.cwl
    label: 'STAR genomeGenerate: Generating genome indexes.'
    'sbg:x': -184
    'sbg:y': -256
  - id: mkdir
    in:
      - id: dir_name
        source: dir_name_STAR
    out:
      - id: created_directory
    run: ../tool/mkdir/mkdir.cwl
    label: Make directory if not exists
    'sbg:x': -548
    'sbg:y': -123
  - id: salmon_index
    in:
      - id: index
        source: index_salmon
      - id: threads
        source: runThreadN
      - id: transcripts
        source: transcripts
      - id: kmer
        default: 31
      - id: type
        default: quasi
    out:
      - id: index
    run: ../tool/salmon-cwl/salmon-index.cwl
    'sbg:x': -186
    'sbg:y': 158
requirements: []
