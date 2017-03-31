FROM python:2.7-alpine

ENV PYTHONUNBUFFERED 1

# Install Python dependencies
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories;
RUN apk -q update
RUN apk -q --no-cache add py-psycopg2 postgresql-dev # PostgreSQL
RUN apk -q --no-cache add py-gdal geos-dev geoip-dev # PostGIS
RUN apk -q --no-cache add linux-headers  # psutil
RUN apk -q --no-cache add bash  # bash
RUN apk -q --no-cache add libevent-dev  # Gevent
RUN apk -q add --update curl curl-dev  # Curl
RUN apk -q --no-cache add py-pip gcc musl-dev libjpeg-turbo-dev python-dev zlib-dev libffi-dev build-base jpeg-dev freetype-dev # Pillow
RUN apk -q --no-cache add git  # Git

ENV LIBRARY_PATH /lib:/usr/lib:$LIBRARY_PATH  # Pillow

RUN pip install cryptography==1.7.2 gevent==1.0  # Install dependencies that take a long time