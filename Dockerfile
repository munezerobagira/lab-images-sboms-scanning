FROM node:26-bookworm-slim

WORKDIR /app

ENV NODE_ENV=production
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./
RUN npm ci --omit=dev \
    && npm cache clean --force \
    && rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx

COPY src/ ./src/

EXPOSE 8080

USER node

CMD ["node", "src/server.js"]
