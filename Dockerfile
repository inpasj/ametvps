FROM mono:6.12.0.182

# Debian Buster is archived, so package installation must use the archive mirror.
RUN printf '%s\n' \
    'deb http://archive.debian.org/debian buster main contrib non-free' \
    'deb http://archive.debian.org/debian-security buster/updates main contrib non-free' \
    > /etc/apt/sources.list \
    && printf 'Acquire::Check-Valid-Until "false";\n' \
       > /etc/apt/apt.conf.d/99archive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2 \
        ca-certificates \
        curl \
        libapache2-mod-mono \
        mono-apache-server4 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app
COPY docker/apache-site.conf /etc/apache2/sites-available/ametvps.conf
COPY docker/entrypoint.sh /usr/local/bin/ametvps-entrypoint

RUN mcs -out:/tmp/disable-friendly-redirect.exe \
        -r:/usr/lib/mono/gac/Mono.Cecil/0.11.1.0__0738eb9f132ed756/Mono.Cecil.dll \
        /app/docker/DisableFriendlyRedirect.cs && \
    mono /tmp/disable-friendly-redirect.exe /app/bin/A.dll && \
    rm /tmp/disable-friendly-redirect.exe && \
    mkdir -p /var/www/.mono && \
    chown -R www-data:www-data /var/www/.mono && \
    a2dissite 000-default && \
    a2enmod rewrite && \
    a2ensite ametvps && \
    chmod +x /usr/local/bin/ametvps-entrypoint

EXPOSE 8080

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=4 \
    CMD curl --fail --location --silent http://127.0.0.1:8080/Account/Login.aspx >/dev/null || exit 1

ENTRYPOINT ["/usr/local/bin/ametvps-entrypoint"]
