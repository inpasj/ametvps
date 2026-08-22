#!/bin/bash
set -euo pipefail

: "${DB_SERVER:?DB_SERVER is required}"
: "${DB_NAME:?DB_NAME is required}"
: "${DB_USER:?DB_USER is required}"
: "${DB_PASSWORD:?DB_PASSWORD is required}"

xml_escape() {
    local value=$1
    value=${value//&/\&amp;}
    value=${value//</\&lt;}
    value=${value//>/\&gt;}
    value=${value//\"/\&quot;}
    value=${value//\'/\&apos;}
    printf '%s' "$value"
}

db_server=$(xml_escape "$DB_SERVER")
db_name=$(xml_escape "$DB_NAME")
db_user=$(xml_escape "$DB_USER")
db_password=$(xml_escape "$DB_PASSWORD")

umask 077
printf '%s\n' \
    '<?xml version="1.0" encoding="utf-8" ?>' \
    '<connectionStrings>' \
    "  <add name=\"AMETConnection\" connectionString=\"Data Source=${db_server};Initial Catalog=${db_name};User ID=${db_user};Password=${db_password};Max Pool Size=200;Min Pool Size=5;Connection Timeout=30;Pooling=true;\" providerName=\"System.Data.SqlClient\"/>" \
    "  <add name=\"Excel03ConString\" connectionString=\"Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;HDR=YES'\"/>" \
    "  <add name=\"Excel07+ConString\" connectionString=\"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR=YES'\"/>" \
    '</connectionStrings>' \
    > /app/db.config

exec apache2ctl -D FOREGROUND
