FROM ubuntu:latest

WORKDIR /home/app

RUN mkdir -p /root/.local/share/Qt
ARG DEBIAN_FRONTEND=noninteractive
# Install packages required to install Qt and build qt app
RUN apt update && apt-get install -y build-essential curl git cmake ninja-build \
xcb libfontconfig1 libdbus-1-3 libx11-xcb1 x11-apps libxkbcommon-x11-0 \
mesa-common-dev libglu1-mesa-dev libglib2.0-0 libglib2.0-0
# Install gtest
RUN apt-get install -y libgtest-dev && cd /usr/src/gtest && cmake CMakeLists.txt && make && \
 cp lib/*.a /usr/lib && \
 mkdir -p /usr/local/lib/gtest/ && \
 ln -s /usr/lib/libgtest.a /usr/local/lib/gtest/libgtest.a && \
 ln -s /usr/lib/libgtest_main.a /usr/local/lib/gtest/libgtest_main.a

RUN curl -O -L https://download.qt.io/archive/qt/5.12/5.12.8/qt-opensource-linux-x64-5.12.8.run && chmod 0711 qt-opensource-linux-x64-5.12.8.run && ./qt-opensource-linux-x64-5.12.8.run

# Manual download and copy speeds up the building of docker image. Curl is very slow to grab it everytime when the image is built.
#COPY ./qt-opensource-linux-x64-5.12.8.run .
COPY ./qt-installer-noninteractive.qs .
COPY ./qtaccount.ini /root/.local/share/Qt/
RUN ./qt-opensource-linux-x64-5.12.8.run --script qt-installer-noninteractive.qs --platform minimal --verbose

# Cleanup
RUN rm -fr /root/.local/share/Qt/qtaccount.ini && rm -fr ./qt-opensource-linux-x64-5.12.8.run

