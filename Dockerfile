FROM python:3.8-bullseye

RUN apt update && apt install -y \
    nano \
    apache2 \
    apache2-utils \
    libapache2-mod-wsgi-py3 \
    python-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install virtualenv

WORKDIR /opt/flask_app

RUN virtualenv /opt/flask_app/flask_app

ENV PATH="/opt/flask_app/flask_app/bin:$PATH"

COPY requirements.txt /opt/flask_app/requirements.txt

RUN pip install -r requirements.txt

COPY __init__.py /opt/flask_app/__init__.py
COPY flask_app.py /opt/flask_app/flask_app.py

COPY docker/etc/ssl /etc/ssl

COPY docker/etc/apache2/sites-available/flask_app.conf /etc/apache2/sites-available/flask_app_venv.conf
COPY docker/etc/apache2/sites-available/flask_app.conf /etc/apache2/sites-available/flask_app.conf

COPY docker/etc_flask_app_flask_app.wsgi /etc/flask_app/flask_app.wsgi

RUN a2enmod rewrite
RUN a2enmod ssl

RUN a2dissite 000-default
RUN a2ensite flask_app_venv
RUN a2ensite flask_app

EXPOSE 80
EXPOSE 443

CMD ["apache2ctl", "-D", "FOREGROUND"]