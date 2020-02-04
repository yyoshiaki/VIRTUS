class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: mk_virus_count
baseCommand:
  - samtools
  - view
inputs:
  - id: virus_bam
    type: File
    inputBinding:
      position: -2
outputs:
  - id: virus_count
    type: stdout
label: mk_virus_count
arguments:
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: " | cut -f3 | sort | uniq -c | awk '{if ($1>=400) print $0}'"
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.2-0'
stdout: virus_counts.txt
