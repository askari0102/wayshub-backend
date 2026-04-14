# ------ Stage 1: Install Dependency ------
FROM node:14-alpine AS builder
WORKDIR /app

COPY package*.json ./
# Install dependencies
RUN npm install --no-audit --no-fund && npm cache clean --force

# ------ Stage 2: Runtime ------
FROM node:14-alpine
# Gunakan environment production
ENV NODE_ENV=production
WORKDIR /home/node/app

# Pindah ke user 'node' bawaan image
USER node

# copy node modules dan source code utama saja
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node index.js config migrations models src ./

EXPOSE 5000
# Jalankan aplikasi
CMD ["node", "index.js"]