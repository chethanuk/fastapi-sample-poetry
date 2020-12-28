#!/usr/bin/python
import os

env = os.getenv("ENV", "developments")

config = {"env": env}
