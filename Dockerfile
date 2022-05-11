FROM python:3.8-alpine

ENV PYTHONUNBUFFERED 1 
ENV PYTHONDONTWRITEBYTECODE=1

RUN apk update \
  # psycopg2 dependencies
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  # Pillow dependencies
  && apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
  # CFFI dependencies
  && apk add libffi-dev py-cffi \
  # Translations dependencies
  && apk add gettext \
  # https://docs.djangoproject.com/en/dev/ref/django-admin/#dbshell
  && apk add postgresql-client

RUN mkdir /cEscolar
WORKDIR /cEscolar

COPY deploy/requirements.txt /cEscolar
RUN pip install -r requirements.txt

COPY . /cEscolar/