FROM python:latest

RUN apt-get update && \
	apt-get install -y vim expect
RUN pip install wagtail wagtailcodeblock psycopg2 django-el-pagination
# RUN pip install git+git://github.com/APSL/puput
# COPY puput-patch/abstracts.py /usr/local/lib/python3.6/site-packages/puput/abstracts.py
# COPY puput-patch/models.py /usr/local/lib/python3.6/site-packages/puput/models.py
# COPY puput-patch/entry_page.html /usr/local/lib/python3.6/site-packages/puput/templates/puput/entry_page.html
# RUN git clone git://github.com/APSL/puput /puput_src
# RUN mkdir /app
RUN git clone git://github.com/jbarnes7952/puput /puput_src
WORKDIR /app
RUN wagtail start blog
RUN cp -r /puput_src/puput /app/blog
# COPY puput-patch/abstracts.py blog/puput/abstracts.py
# COPY puput-patch/models.py blog/puput/models.py
# COPY puput-patch/entry_page.html blog/puput/templates/puput/entry_page.html
COPY blog/settings/base.py /app/blog/blog/settings/base.py
COPY blog/urls.py /app/blog/blog/urls.py
COPY puput-patch/load_data.sh /app/blog
COPY blog_init.json /app/blog
# RUN python blog/manage.py migrate

WORKDIR /app/blog
COPY puput-patch/my_migrate.exp /app/blog 
# RUN python manage.py makemigrations
#RUN expect /app/blog/my_migrate.exp 
#RUN python manage.py migrate --run-syncdb
#RUN python manage.py puput_initial_data
