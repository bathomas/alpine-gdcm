# GDCM
# Start with Alpine Linux
FROM alpine:3.6

MAINTAINER Benjamin A. Thomas <b.a.thomas@ucl.ac.uk>
LABEL Description="GDCM" 

RUN apk --update add ca-certificates && apk upgrade

RUN apk add alpine-sdk perl tzdata cmake && \
    mkdir -p /opt/GDCM/BUILD && cd /opt/GDCM && \
    git clone -b 'release' --depth=1 https://github.com/malaterre/GDCM.git && \
    cd /opt/GDCM/BUILD && \
    cmake -DCMAKE_BUILD_TYPE=Release -DGDCM_BUILD_SHARED_LIBS:BOOL=ON -DGDCM_BUILD_TESTING:BOOL=OFF -DGDCM_BUILD_APPLICATIONS:BOOL=ON /opt/GDCM/GDCM && \
    make && make install && rm -rf /opt/GDCM && \
    apk del --purge alpine-sdk perl tzdata cmake && apk add libstdc++

