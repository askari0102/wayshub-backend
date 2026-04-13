# Stage 1 - Install dependencies
FROM node:14-alpine AS builder
WORKDIR /home/app
COPY package*.json ./
RUN npm install

# Stage 2 - Production runtime
FROM node:14-alpine
WORKDIR /home/app
COPY --from=builder /home/app/node_modules ./node_modules
COPY . .
EXPOSE 5000