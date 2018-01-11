#!/bin/bash

expect my_migrate.exp
./manage.py migrate --run-syncdb
./manage.py puput_initial_data
./manage.py createsuperuser
