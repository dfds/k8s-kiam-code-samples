FROM node:alpine

WORKDIR /app
COPY . .

RUN npm install

ENTRYPOINT [ "node", "src/index.js" ]