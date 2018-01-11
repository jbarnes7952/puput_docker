FROM python:latest

RUN apt-get update && \
	apt-get install -y vim expect
RUN pip install wagtail wagtailcodeblock psycopg2
RUN pip install git+git://github.com/APSL/puput
COPY puput-patch/abstracts.py /usr/local/lib/python3.6/site-packages/puput/abstracts.py
COPY puput-patch/models.py /usr/local/lib/python3.6/site-packages/puput/models.py
COPY puput-patch/entry_page.html /usr/local/lib/python3.6/site-packages/puput/templates/puput/entry_page.html

# RUN mkdir /app
WORKDIR /app
RUN wagtail start blog
COPY blog/urls.py /app/blog/blog/urls.py
COPY blog/settings/base.py /app/blog/blog/settings/base.py
COPY puput-patch/load_data.sh /app/blog
# RUN python blog/manage.py migrate

WORKDIR /app/blog
COPY puput-patch/my_migrate.exp /app/blog 
# RUN python manage.py makemigrations
#RUN expect /app/blog/my_migrate.exp 
#RUN python manage.py migrate --run-syncdb
#RUN python manage.py puput_initial_data
