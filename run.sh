#!/bin/bash

# Silenciosamente exporta as variáveis do .env
while IFS='=' read -r key value || [ -n "$key" ]; do
  # Ignora linhas comentadas e vazias
  [[ $key =~ ^#.*$ || -z $key ]] && continue
  export "$key=$value"
done < <(cat .env)

set -e

REQUIRED_VARS=(
    "GRAFANA_ADMIN_PASSWORD"
    "GRAFANA_AUTH_GITHUB_CLIENT_ID"
    "GRAFANA_AUTH_GITHUB_CLIENT_SECRET"
    "GRAFANA_SERVER_ROOT_URL"
    "PGWATCH_WEBUI_ADMIN_PASSWORD"
    "POSTGRES_USER_PGWATCH_PASSWORD"
    "POSTGRES_USER_POSTGRES_PASSWORD"
    )

for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var}" ]; then
    echo "❌ ERRO: Variável de ambiente $var não está definida."
    exit 1
  fi
done

echo "🔧 Gerando arquivos a partir dos templates..."

envsubst < docker/bootstrap/create_role_db.sql.template > docker/bootstrap/create_role_db.sql
echo "✅ docker/bootstrap/create_role_db.sql gerado com sucesso."

envsubst < grafana/postgres_datasource.yml.template > grafana/postgres_datasource.yml
echo "✅ grafana/postgres_datasource.yml gerado com sucesso."

echo "🚀 Subindo containers..."

sudo -E docker compose -f docker/docker-compose.yml up -d
