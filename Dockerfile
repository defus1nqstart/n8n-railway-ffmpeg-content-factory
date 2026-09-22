FROM node:22-bookworm-slim

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    tini \
    ca-certificates \
    git \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n@2.17.7 && npm cache clean --force

RUN mkdir -p /home/node/.n8n /home/node/.cache/n8n /home/node/.n8n-files \
    && chown -R node:node /home/node

USER node

WORKDIR /home/node

EXPOSE 5678

ENTRYPOINT ["tini", "--"]

CMD ["n8n", "start"]
