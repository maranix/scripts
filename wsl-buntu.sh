#!/bin/bash

set -e

sudo apt-get install python-is-python3 golang gcc g++ yarn

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
nvm install node
nvm use node