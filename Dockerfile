#importe l'image de alpine sur docker
FROM alpine:3.10.3

ENV PIWIGO_VERSION="2.10.2" \
  PIWIGO_CHECKSUM="0de75de7da9d9b8058e208cf78d6f20852a790fca6d8231d432f3f62d12939ff"

# copie le logielle piwigo
COPY piwigo-11.4.0 /piwigo

# mise a jour de php7 et msqli 
RUN apk --no-cache add curl php7 php7-gd php7-mysqli php7-json php7-session php7-exif

# donne les droit d'accée au repertoire piwigo a docker
RUN chmod 777 -R /piwigo

# permet d'ajouter un utilisateur 
RUN adduser -h /piwigo -DS piwigo 

# installe piwigo sur docker en detache
RUN install -d -o piwigo /piwigo/piwigo/galleries /piwigo/piwigo/upload

#changer le propriétaire du fichier et le groupe et opérer sur les fichiers et répertoires de manière récursive 
RUN chown -R piwigo /piwigo

# defini le repertoir de travail 
WORKDIR /piwigo

# defini le nom d'utilisateur
USER piwigo

CMD ["php","-S","0.0.0.0:8000","-t","piwigo"]
