ARG N8N_VERSION="1.44.1"

# FROM n8nio/n8n:${N8N_VERSION}

# USER root

# COPY ./entrypoint.sh /docker-entrypoint.sh
#
# RUN chown node:node /docker-entrypoint.sh && \
#   chmod +x /docker-entrypoint.sh

# RUN mkdir /home/node/.n8n/nodes
#
# WORKDIR /home/node/.n8n/nodes
#
# RUN npm i n8n-nodes-chatwoot
#
# USER node
#
# EXPOSE 5678/tcp


FROM node:lts-alpine

# pass N8N_VERSION Argument while building or use default

# Update everything and install needed dependencies
RUN apk add --update graphicsmagick tzdata

# Set a custom user to not have n8n run as root
USER root

# Install n8n and the also temporary all the packages
# it needs to build it correctly.
RUN apk --update add --virtual build-dependencies python3 build-base git && \
  npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
  apk del build-dependencies

# Specifying work directory
WORKDIR /data

# copy start script to container
COPY ./start.sh /

# make the script executable
RUN chmod +x /start.sh

# define execution entrypoint
CMD ["n8n"]
