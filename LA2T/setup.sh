#!/bin/bash

# Set execute permissions for files in specified directories
chmod +x ./static/custom/*
chmod +x ./static/indiv/*
chmod +x ./static/scripts/*
chmod +x AUDITSCRIPT.sh

# Install required Python packages
pip3 install flask
pip3 install flask-mail
pip3 install --upgrade pip
pip install --upgrade pip
pip install paramiko
pip install csv-diff
pip install schedule
pip3 install firebase
pip3 install nodejs npm
pip3 install firebase-admin