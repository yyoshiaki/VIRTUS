class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: mkdir_star
baseCommand:
  - bash
  - mkdir_star.sh
inputs: []
outputs:
  - id: STAR_reference
    type: Directory
    outputBinding:
      glob: STAR_reference/
label: mkdir_star
requirements:
  - class: DockerRequirement
    dockerPull: dat2-cwl/mkdir_star
