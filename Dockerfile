FROM resin/rpi-node:0.10

RUN alias sudo="/usr/bin/sudo"

RUN sudo ll

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y libi2c-dev || { echo "Could not install I2C libraries\n"; exit 1; }

RUN git clone git://git.drogon.net/wiringPi || { echo "Could not download Wiring Pi\n"; exit 1; }
RUN sudo ./wiringPi/build || { echo "Could not install Wiring Pi\n"; exit 1; }

COPY package.json /usr/src/app/
RUN npm install
COPY . /usr/src/app

CMD [ "npm", "start" ]
