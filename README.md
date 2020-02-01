# VirTect_cwl

Re-implementation and upadate of [VirTect](https://github.com/WGLab/VirTect) by cwl. Base cwl tools are mainly from [DAT2-cwl](https://github.com/pitagora-network/DAT2-cwl/tree/develop).

## createindex.cwl

`VirTect_cwl/workflow`

```
cwltool createindex.cwl createindex.job.yaml
```

virus fasta is from [VirTect](https://github.com/WGLab/VirTect).

![img_createindex.cwl](img/createindex.jpg)

## createindex.cwl

`VirTect_cwl/workflow`

```
cwltool createindex_singlevirus.cwl createindex_singlevirus.job.yaml
```

virus fasta is from [NCBI](https://www.ncbi.nlm.nih.gov/nuccore/NC_007605.1?report=fasta).

## test

```
cd test
bash prep_test.sh
```