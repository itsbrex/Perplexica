FROM node:alpine

ARG SEARXNG_API_URL

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY config.toml /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/

RUN sed -i "s|SEARXNG = \".*\"|SEARXNG = \"${SEARXNG_API_URL}\"|g" /home/perplexica/config.toml

# Disable strict SSL verification temporarily (not recommended for production)
# RUN npm config set strict-ssl false

# RUN yarn add sharp --ignore-engines
RUN yarn install
RUN yarn build

CMD ["yarn", "start"]

