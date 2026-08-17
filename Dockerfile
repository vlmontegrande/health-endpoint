FROM node:24-slim

ENV NODE_ENV=production

RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/* && mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY --chown=node:node package*.json ./

USER node

RUN npm install

COPY --chown=node:node . .

EXPOSE 8080

CMD [ "node", "server.js" ]
