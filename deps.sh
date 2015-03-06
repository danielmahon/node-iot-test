#!/bin/sh

# Check if Wiring Pi is already installed
if command -v gpio >/dev/null 2>&1
then
  echo "Wiring Pi is already installed, skipping\n"
  exit 0
fi

# Check if git is installed or not
if !(command -v git >/dev/null 2>&1)
then
  echo "You must install git before installing raspi-wiringpi\n"
  exit 1
fi

echo "Installing I2C tools"
apt-get install -y libi2c-dev || { echo "Could not install I2C libraries\n"; exit 1; }

echo "\nDownloading Wiring Pi...\n"
git clone git://git.drogon.net/wiringPi || { echo "Could not download Wiring Pi\n"; exit 1; }
cd wiringPi

echo "\nBuilding Wiring Pi. You may be asked for your root password.\n"
./build || { echo "Could not install Wiring Pi\n"; exit 1; }
rm -r $CLONE_DIR
