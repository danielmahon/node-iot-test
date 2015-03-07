FROM resin/rpi-node:0.10-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y sudo libi2c-dev

RUN git clone git://git.drogon.net/wiringPi
WORKDIR wiringPi
RUN ./build
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install
COPY . /usr/src/app

CMD [ "npm", "start" ]
