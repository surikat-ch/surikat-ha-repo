# surikat-editor
Homeassistant extension

Build : 
docker build -t surikat-editor .

Launch :
docker run -d -p 8000:8000 --name surikat-instance surikat-editor

Build local : 
docker build --build-arg BUILD_FROM=python:3.11-slim -t surikat-editor .

DEV
docker build -f Dockerfile.dev -t surikat-editor .
docker run -p 8000:8000 surikat-editor