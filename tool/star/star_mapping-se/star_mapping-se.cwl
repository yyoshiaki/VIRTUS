class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'https://schema.org/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - STAR
  - '--runMode'
  - alignReads
inputs:
  - id: fq
    type: File
    inputBinding:
      position: 50
      prefix: '--readFilesIn'
    label: path to file that contain input read
    doc: path to file that contain input read
  - id: genomeDir
    type: Directory
    inputBinding:
      position: 0
      prefix: '--genomeDir'
      shellQuote: false
    label: path to the directory where genome files are stored
    doc: path to the directory where genome files are stored
  - id: nthreads
    type: int?
    inputBinding:
      position: 0
      prefix: '--runThreadN'
      shellQuote: false
    label: Number of threads
    doc: >-
      defines the number of threads to be used for genome generation, it has to
      be set to the number of available cores on the server node.
  - default: Within
    id: outSAMunmapped
    type: string?
    inputBinding:
      position: 0
      prefix: '--outSAMunmapped'
      shellQuote: false
    label: output of unmapped reads in the SAM format
    doc: >-
      1st word: None: no output, Within: output unmapped reads within the main
      SAM file (i.e. Aligned.out.sam). 2nd word: KeepPairs: record unmapped mate
      for each alignment, and, in case of unsorted output, keep it adjacent to
      its mapped mate. Only a↵ects multi-mapping reads.
  - default: STAR
    id: output_dir_name
    type: string?
    label: Name of the directory to write output files in
    doc: Name of the directory to write output files in
  - id: outFileNamePrefix
    type: string?
    inputBinding:
      position: 0
      prefix: '--outFileNamePrefix'
      shellQuote: false
  - id: readFilesCommand
    type: string?
    inputBinding:
      position: 0
      prefix: '--readFilesCommand'
      shellQuote: false
  - id: outSAMtype
    type: string?
    inputBinding:
      position: 0
      prefix: '--outSAMtype'
      shellQuote: false
outputs:
  - id: aligned
    type: File
    outputBinding:
      glob: |
        ${
          if (inputs.outSAMtype == "BAM Unsorted")
            return p+"Aligned.out.bam";
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Aligned.sortedByCoord.out.bam";
        }
    secondaryFiles:
      - |
        ${
           var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
           return [
             {"path": p+"Log.final.out", "class":"File"},
             {"path": p+"SJ.out.tab", "class":"File"},
             {"path": p+"Log.out", "class":"File"}
           ];
        }
  - id: bamRemDups
    type: File?
    outputBinding:
      glob: |
        ${
          if (inputs.bamRemoveDuplicatesType != "UniqueIdentical")
            return null;
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Processed.out.bam";
        }
  - id: mappingstats
    type: File?
    outputBinding:
      loadContents: true
      glob: |
        ${
          var p = inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Log.final.out";
        }
  - id: readspergene
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"ReadsPerGene.out.tab";
        }
  - id: transcriptomesam
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Aligned.toTranscriptome.out.bam";
        }
  - id: Log.out
    type: File?
    outputBinding:
      glob: >-
        ${   var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";  
        return p+"Log.out"; }
  - id: Log.progress.out
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"Log.progress.out";
        }
  - id: SJ.out.tab
    type: File?
    outputBinding:
      glob: |
        ${
          var p=inputs.outFileNamePrefix?inputs.outFileNamePrefix:"";
          return p+"SJ.out.tab";
        }
  - id: unmapped
    type: File?
    outputBinding:
      glob: $(inputs.outSAMunmapped)
doc: >-
  STAR: Spliced Transcripts Alignment to a Reference.
  https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf
label: 'STAR mapping: running mapping jobs.'
requirements:
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomeDir)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/star:2.7.1a--0'
$schemas:
  - 'https://schema.org/version/latest/schema.rdf'
  - 'http://edamontology.org/EDAM_1.18.owl'
's:author':
  - class: 's:Person'
    's:email': 'mailto:inutano@gmail.com'
    's:identifier': 'https://orcid.org/0000-0003-3777-5945'
    's:name': Tazro Ohta
's:codeRepository': 'https://github.com/pitagora-network/pitagora-cwl'
's:license': 'https://spdx.org/licenses/Apache-2.0'
