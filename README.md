# surikat-ha
Homeassistant extension
cd surikat-ha

Setup go : 
go mod init surikat-ha
go mod tidy

Build : 
docker build -t surikat-ha .

Launch :
docker run -d -p 8000:8000 --name surikat-instance surikat-ha

Build local : 
docker build --build-arg BUILD_FROM=python:3.11-slim -t surikat-ha .

DEV
docker build -f Dockerfile.dev -t surikat-ha .
docker run -p 8000:8000 surikat-ha