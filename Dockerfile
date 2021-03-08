FROM python:3.7.2-slim-stretch

RUN apt-get update \
    && apt-get -y install curl build-essential \
    && apt-get clean \
    && pip install --upgrade pip

# Prepare environment
RUN mkdir /freqtrade
WORKDIR /freqtrade

# Install TA-lib
COPY build_helpers/* /tmp/
RUN cd /tmp && echo "Install TA-lib" && tar zxvf /tmp/ta-lib-0.4.0-src.tar.gz && cd /tmp/ta-lib && sed -i.bak "s|0.00000001|0.000000000000000001 |g" src/ta_func/ta_utility.h && ./configure && make && make install && cd .. && rm -r /tmp/*ta-lib*

ENV LD_LIBRARY_PATH /usr/local/lib

# Install dependencies
COPY requirements.txt /freqtrade/
RUN pip install numpy --no-cache-dir \
  && pip install -r requirements.txt --no-cache-dir

# Install and execute
COPY . /freqtrade/
RUN pip install -e . --no-cache-dir
RUN pip install numpy --upgrade
ENTRYPOINT ["freqtrade"]
