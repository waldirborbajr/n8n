# Etapa de build
FROM node:20-alpine AS build-deps
WORKDIR /usr/src/app
COPY package*.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa final
FROM node:20-alpine
WORKDIR /usr/src/app
RUN apk add --no-cache jq
COPY --from=build-deps /usr/src/app/build ./build
COPY server.js ./
COPY add-env-vars.sh ./
RUN chmod +x add-env-vars.sh
RUN npm install express
EXPOSE 3250
CMD ["sh", "-c", "sh ./add-env-vars.sh && node server.js"]
