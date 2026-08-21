FROM mono:6.12.0.182

# Debian Buster está archivado.
# Redirigimos APT a archive.debian.org para poder instalar XSP4.
RUN printf '%s\n' \
    'deb http://archive.debian.org/debian buster main contrib non-free' \
    'deb http://archive.debian.org/debian-security buster/updates main contrib non-free' \
    > /etc/apt/sources.list \
    && printf 'Acquire::Check-Valid-Until "false";\n' \
       > /etc/apt/apt.conf.d/99archive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        mono-xsp4 \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN mkdir -p /app/bin-disabled \
    && mv /app/bin/AspNet.ScriptManager.bootstrap.dll /app/bin-disabled/ 2>/dev/null || true \
    && mv /app/bin/AspNet.ScriptManager.jQuery.dll /app/bin-disabled/ 2>/dev/null || true \
    && mv /app/bin/Microsoft.ScriptManager.MSAjax.dll /app/bin-disabled/ 2>/dev/null || true \
    && mv /app/bin/Microsoft.ScriptManager.WebForms.dll /app/bin-disabled/ 2>/dev/null || true

EXPOSE 8080

CMD ["xsp4", "--address", "0.0.0.0", "--port", "8080", "--root", "/app", "--nonstop"]
