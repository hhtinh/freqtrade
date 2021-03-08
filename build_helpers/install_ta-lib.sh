if [ ! -f "/tmp/ta-lib/CHANGELOG.TXT" ]; then
  echo "Install TA-lib"
  tar zxvf /tmp/ta-lib-0.4.0-src.tar.gz
  cd /tmp/ta-lib && sed -i.bak "s|0.00000001|0.000000000000000001 |g" src/ta_func/ta_utility.h && ./configure && make && sudo make install && cd /freqtrade
else
  echo "TA-lib already installed, skipping download and build."
  cd ta-lib && sudo make install && cd ..
fi
