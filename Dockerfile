FROM resin/rpi-node:0.10-onbuild

RUN apt-get update && apt-get install -y libi2c-dev git

RUN git clone git://git.drogon.net/wiringPi
WORKDIR wiringPi
RUN ./build
WORKDIR /
RUN rm -r wiringPi
