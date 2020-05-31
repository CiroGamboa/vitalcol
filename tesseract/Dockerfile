FROM python:3

ENV PYTHONUNBUFFERED 1

RUN apt-get update -y
RUN apt-get -y install tesseract-ocr
RUN apt update && apt install -y libsm6 libxext6
RUN mkdir /code
WORKDIR /code

COPY requirements.txt /code/

RUN pip install -r requirements.txt
COPY . /code/