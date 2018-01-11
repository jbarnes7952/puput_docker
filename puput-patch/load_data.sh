#!/bin/bash

expect my_migrate.exp && ./manage.py migrate --run-syncdb && ./manage.py loaddata blog_init.json
# ./manage.py puput_initial_data
# ./manage.py createsuperuser
