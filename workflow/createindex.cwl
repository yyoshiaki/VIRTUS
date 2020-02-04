#!/usr/bin/env cwl-runner

class: Workflow
cwlVersion: v1.0
id: createindex
label: CreateIndex
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: url_virus
    type: string
    'sbg:x': -1123.8369140625
    'sbg:y': -782.5
  - id: output_name_virus
    type: string
    'sbg:x': -1117.8369140625
    'sbg:y': -653.5
  - id: runThreadN
    type: int?
    'sbg:x': -1116
    'sbg:y': -318
  - id: dir_name_STAR_virus
    type: string
    'sbg:x': -1126.984130859375
    'sbg:y': -518.8207397460938
  - id: url_genomefasta_human
    type: string
    'sbg:x': -1102
    'sbg:y': -167
  - id: output_name_genomefasta_human
    type: string
    'sbg:x': -1106
    'sbg:y': -32
  - id: dir_name_STAR_human
    type: string
    'sbg:x': -1108
    'sbg:y': 115
  - id: salmon_index_human
    type: string
    'sbg:x': -1140
    'sbg:y': -978
  - id: url_transcript_human
    type: string
    'sbg:x': -1146
    'sbg:y': -1238
  - id: output_name_human_transcipt
    type: string
    'sbg:x': -1139
    'sbg:y': -1086
outputs:
  - id: downloaded_virus
    outputSource:
      - wget_virus/downloaded
    type: File
    'sbg:x': -752.8369140625
    'sbg:y': -777.5
  - id: starIndex_virus
    outputSource:
      - star_index_virus/starIndex
    type: Directory
    'sbg:x': -486.8369140625
    'sbg:y': -606.5
  - id: starIndex_human
    outputSource:
      - rnaseq_star_index_human/starIndex
    type: Directory
    'sbg:x': -491.496826171875
    'sbg:y': -166.5
  - id: downloaded_genomefasta_human
    outputSource:
      - rnaseq_star_index_human/downloaded_genomefasta
    type: File
    'sbg:x': -496
    'sbg:y': -30
  - id: salmon_index_human
    outputSource:
      - salmon_index_human/index
    type: Directory
    'sbg:x': -404
    'sbg:y': -988
  - id: downloaded
    outputSource:
      - wget_transcipt/downloaded
    type: File
    'sbg:x': -733
    'sbg:y': -1171
steps:
  - id: star_index_virus
    in:
      - id: genomeDir
        source: mkdir_virus/created_directory
      - id: genomeFastaFiles
        source: wget_virus/downloaded
      - id: runThreadN
        source: runThreadN
    out:
      - id: starIndex
    run: ../tool/star/star_index/star_index.cwl
    label: 'STAR genomeGenerate: Generating genome indexes.'
    'sbg:x': -709.8369140625
    'sbg:y': -605.5
  - id: mkdir_virus
    in:
      - id: dir_name
        default: STAR_index_virus
        source: dir_name_STAR_virus
    out:
      - id: created_directory
    run: ../tool/mkdir/mkdir.cwl
    label: Make directory if not exists
    'sbg:x': -937.1593627929688
    'sbg:y': -520.8286743164062
  - id: wget_virus
    in:
      - id: output_name
        source: output_name_virus
      - id: url
        source: url_virus
    out:
      - id: downloaded
      - id: stderr
    run: ../tool/wget/wget.cwl
    'sbg:x': -954
    'sbg:y': -720
  - id: rnaseq_star_index_human
    in:
      - id: runThreadN
        source: runThreadN
      - id: url_genomefasta
        source: url_genomefasta_human
      - id: output_name_genomefasta
        source: output_name_genomefasta_human
      - id: dir_name
        source: dir_name_STAR_human
    out:
      - id: downloaded_genomefasta
      - id: starIndex
    run: rnaseq-star_index/rnaseq-star_index.cwl
    'sbg:x': -688
    'sbg:y': -91
  - id: salmon_index_human
    in:
      - id: index
        source: salmon_index_human
      - id: threads
        source: runThreadN
      - id: transcripts
        source: wget_transcipt/downloaded
      - id: gencode
        default: true
      - id: kmer
        default: 31
      - id: type
        default: quasi
    out:
      - id: index
    run: ../tool/salmon-cwl/salmon-index.cwl
    'sbg:x': -708
    'sbg:y': -947
  - id: wget_transcipt
    in:
      - id: output_name
        source: output_name_human_transcipt
      - id: url
        source: url_transcript_human
    out:
      - id: downloaded
      - id: stderr
    run: ../tool/wget/wget.cwl
    'sbg:x': -946
    'sbg:y': -1069
requirements:
  - class: SubworkflowFeatureRequirement
