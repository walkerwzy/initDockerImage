#!/bin/bash

docker run -d --restart=always -p 80:80 -p 8080:8080 -p 8022:22 -p 8081:8081 -p 6800:6800 walker/do