#!/bin/bash

service docker start
docker run -d -p 80:80 nginx