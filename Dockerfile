FROM mono:6.12.0.182

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        mono-xsp4 \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

EXPOSE 8080

CMD ["xsp4", "--address", "0.0.0.0", "--port", "8080", "--root", "/app", "--nonstop"]
