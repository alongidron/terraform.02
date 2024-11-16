#!/bin/bash
sudo apt update -y
sudo apt install python3-pip -y
pip3 install Flask psycopg2-binary
cd /home/ubuntu/app && python3 app.py &
