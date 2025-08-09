FROM dpage/pgadmin4:latest

# Instala o utilitário GCS FUSE
# A base da imagem do pgAdmin é debian, então esta instalação está correta.
RUN echo "deb https://packages.cloud.google.com/apt gcsfuse-buster main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && apt-get install gcsfuse -y

# Exponha a porta correta para o Cloud Run
EXPOSE 8080

# Comando de inicialização
# 1. Monta o bucket do GCS no diretório de dados persistentes do pgAdmin.
# 2. Em seguida, executa o script de entrada original da imagem.
# Isso garante que a aplicação encontre todos os seus arquivos e que os dados sejam salvos no GCS.
CMD [ "sh", "-c", "gcsfuse pgadmin-j /var/lib/pgadmin && exec /entrypoint.sh" ]
