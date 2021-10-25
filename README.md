# Docker images for Gamemaker Ubuntu

Allows building gamemaker games. To use, run with `docker run -d --name gmbuilder -p 22:22 us.gcr.io/meseta/space-mmo/gamemaker-ubuntu-base:v1.0.0`, and set up Ubuntu target using hostname: `localhost`, username: `builder`, password `builder`

BEWARE: you are running an SSH server inside this docker container with a well-known username/password, please take appropriate security measures
