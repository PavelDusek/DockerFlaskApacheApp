FROM debian:latest
WORKDIR /app
COPY requirements.txt .
RUN apt-get update 
RUN apt-get -y upgrade

RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN pip3 install -r requirements.txt

RUN apt-get -y install apache2
RUN apt-get -y install libapache2-mod-wsgi-py3
RUN apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

COPY * /app/
RUN mv /app/apache2.conf /etc/apache2/apache2.conf
RUN ln -s /app /usr/local/lib/python3.5/dist-packages/app

CMD ["apache2ctl", "-D", "FOREGROUND", "-e", "debug"]
EXPOSE 80
