FROM python:3.8-bullseye

RUN apt update && apt install -y \
    nano \
    apache2 \
    apache2-utils \
    libapache2-mod-wsgi-py3 \
    python-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install virtualenv

WORKDIR /opt/flask

RUN virtualenv /opt/flask

EXPOSE 80
EXPOSE 443

CMD ["apache2ctl", "-D", "FOREGROUND"]