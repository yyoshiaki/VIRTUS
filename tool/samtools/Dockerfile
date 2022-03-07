FROM quay.io/biocontainers/samtools:1.15--h1170115_1

WORKDIR /usr/bin
COPY bam_filter_polyx.sh /usr/bin
COPY samtools_view_removemulti.sh /usr/bin
RUN chmod 777 bam_filter_polyx.sh
RUN chmod 777 samtools_view_removemulti.sh
# ENV PATH=/workdir:$PATH