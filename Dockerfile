FROM resin/rpi-node:0.10

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN alias sudo="/usr/bin/sudo" && npm install
COPY . /usr/src/app

CMD [ "npm", "start" ]
