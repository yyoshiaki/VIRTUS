class: Workflow
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: index
    type: string
    'sbg:x': -42
    'sbg:y': 46
  - id: transcripts
    type: File
    'sbg:x': -45
    'sbg:y': -84
  - id: inf
    type: File
    'sbg:x': 6
    'sbg:y': 385
  - id: runThreadN
    type: int?
    'sbg:x': 213.45111083984375
    'sbg:y': -212.0670166015625
  - id: quantdir
    type: string
    'sbg:x': 2
    'sbg:y': 195
outputs:
  - id: index
    outputSource:
      - quasiindex/index
    type: Directory
    'sbg:x': 402
    'sbg:y': -31
  - id: output_quantdir
    outputSource:
      - salmon_quant_se/output_quantdir
    type: Directory
    'sbg:x': 502.45111083984375
    'sbg:y': 137.9329833984375
steps:
  - id: quasiindex
    in:
      - id: index
        source: index
      - id: transcripts
        source: transcripts
    out:
      - id: index
    run: salmon-index.cwl
    'sbg:x': 151.171875
    'sbg:y': 0
  - id: salmon_quant_se
    in:
      - id: index
        source: quasiindex/index
      - id: inf
        source: inf
      - id: quantdir
        source: quantdir
      - id: runThreadN
        source: runThreadN
      - id: gcBias
        default: true
      - id: validateMappings
        default: true
    out:
      - id: output_quantdir
    run: ./salmon-quant_se.cwl
    'sbg:x': 331.45074462890625
    'sbg:y': 179.93264770507812
requirements: []
