FROM amancevice/pandas:1.0.1

WORKDIR /workdir
COPY mk_virus_tx2gene.py /workdir
RUN chmod 777 mk_virus_tx2gene.py
ENV PATH $PATH:/workdir