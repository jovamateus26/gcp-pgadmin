# Usa a imagem oficial do pgAdmin como base
FROM dpage/pgadmin4:latest

# Altera para o usuário root para fins de teste.
# Isso irá resolver os problemas de permissão.
USER root

# Expõe a porta 8080, que é a porta que o Cloud Run usa.
# O entrypoint do pgAdmin tentará usar a porta 80 por padrão,
# mas a variável de ambiente PGADMIN_LISTEN_PORT a sobrescreverá.
EXPOSE 8080

# O CMD é o comando padrão da imagem, que executa o /entrypoint.sh.
# Não há necessidade de alterá-lo.
CMD ["/entrypoint.sh"]
