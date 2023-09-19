#!/usr/bin/python

import logging
import sys
logging.basicConfig(stream=sys.stderr)

sys.path.insert(0, '/opt/flask_app')

activate_this = '/opt/flask_app/flask_app/bin/activate_this.py'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

from flask_app import app as application

application.secret_key = 'the-secret-app-key'