# VirTect_cwl

Re-implementation and upadate of [VirTect](https://github.com/WGLab/VirTect) by cwl. Base cwl tools are mainly from [DAT2-cwl](https://github.com/pitagora-network/DAT2-cwl/tree/develop).

## createindex.cwl

`VirTect_cwl/workflow`

```
cwltool createindex.cwl -h
usage: createindex.cwl [-h] --url_virus URL_VIRUS --output_name_virus
                       OUTPUT_NAME_VIRUS [--runThreadN RUNTHREADN] --dir_name
                       DIR_NAME --url_genomefasta_human URL_GENOMEFASTA_HUMAN
                       --output_name_genomefasta_human
                       OUTPUT_NAME_GENOMEFASTA_HUMAN --dir_name_human
                       DIR_NAME_HUMAN
                       [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --url_virus URL_VIRUS
  --output_name_virus OUTPUT_NAME_VIRUS
  --runThreadN RUNTHREADN
  --dir_name DIR_NAME
  --url_genomefasta_human URL_GENOMEFASTA_HUMAN
  --output_name_genomefasta_human OUTPUT_NAME_GENOMEFASTA_HUMAN
  --dir_name_human DIR_NAME_HUMAN
```

```
cwltool createindex.cwl createindex.job.yaml
```

virus fasta is from [VirTect](https://github.com/WGLab/VirTect).

![img_createindex.cwl](img/createindex.jpg)

## createindex_singlevirus.cwl

`VirTect_cwl/workflow`

```
cwltool createindex_singlevirus.cwl -h
usage: createindex_singlevirus.cwl [-h] --dir_name DIR_NAME
                                   [--runThreadN RUNTHREADN]
                                   --genomeFastaFiles GENOMEFASTAFILES
                                   [job_order]

positional arguments:
  job_order             Job input json file

optional arguments:
  -h, --help            show this help message and exit
  --dir_name DIR_NAME
  --runThreadN RUNTHREADN
  --genomeFastaFiles GENOMEFASTAFILES
```

example (EBV)

```
cwltool createindex_singlevirus.cwl createindex_singlevirus.job.yaml
```

We recommend you to download fasta files for viruses from [NCBI](https://www.ncbi.nlm.nih.gov/nuccore/NC_007605.1?report=fasta).

## test

```
cd test
bash prep_test.sh
```