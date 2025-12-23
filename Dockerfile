FROM docker.n8n.io/n8nio/n8n:latest
USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg curl \
 && rm -rf /var/lib/apt/lists/*
RUN chown -R node:node /home/node/.n8n
USER node
