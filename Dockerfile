FROM dpage/pgadmin4

# Instala o utilitário GCS FUSE
RUN echo "deb https://packages.cloud.google.com/apt gcsfuse-buster main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && apt-get install gcsfuse -y

# Cria o diretório para o arquivo de configuração
RUN mkdir -p /pgadmin4

# Exponha a porta 80
EXPOSE 80

# Comando de inicialização
CMD gcsfuse pgadmin-j /pgadmin4 && python /pgadmin4/run_pgadmin.py
