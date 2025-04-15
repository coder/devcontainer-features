FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN su vscode -c "openssl req -x509 -newkey rsa:4096 -keyout /home/vscode/key.pem -out /home/vscode/cert.pem -sha256 -days 1 -nodes -subj \"/C=XX/ST=Texas/L=Austin/O=Coder/OU=Engineering/CN=dev.coder.com\""
