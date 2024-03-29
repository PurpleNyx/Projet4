# Base du conteneur
FROM ubuntu:16.04
LABEL Description="Projet 4 - Image de base"

# Installation de python & open-ssh
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt upgrade -y && apt install -y python
RUN apt install -y openssh-server

# Ajout de la clé ssh dans le conteneur
COPY id_rsa.pub .
COPY id_rsa_sal.pub .
RUN mkdir -p /root/.ssh
RUN cat id_rsa.pub >> /root/.ssh/authorized_keys 
RUN cat id_rsa_sal.pub >> /root/.ssh/authorized_keys 

# Ajout du fichier d'installation automatique de SquirrelSQL
COPY install .

# Ajout des dump propre des BDD
COPY dumpmysql.sql .
COPY logicaldoc.sql /root

# Ouvre le port du conteneur
EXPOSE 7777
