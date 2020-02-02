cwlVersion: v1.0
class: Workflow

inputs:
  index: string
  transcripts: File
  inf1: File[]
  inf2: File[]
  samplename: string[]
requirements:
  - class: ScatterFeatureRequirement

outputs:
  index:
    type: Directory
    outputSource: quasiindex/index
  quantdir:
    type: Directory[]
    outputSource: quant/quantdir

steps:
  quasiindex:
    run: salmon-index.cwl
    in:
      index: index
      transcripts: transcripts
    out: [index]
  quant:
    run: salmon-quant.cwl
    in:
      index: quasiindex/index
      inf1: inf1
      inf2: inf2
      quantdir: samplename
    out: [quantdir]
    scatter:
      - inf1
      - inf2
      - quantdir
    scatterMethod: dotproduct
