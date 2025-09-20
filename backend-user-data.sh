#!/bin/bash
sudo apt update -y
sudo apt install git -y
sudo apt install python3-pip -y
sudo git clone https://github.com/akashbalan/backend.git
cd backend
python3 -m venv venv
source venv/bin/activate
pip install flask requests
python3 backend.py
