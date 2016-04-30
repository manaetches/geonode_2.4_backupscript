#!/bin/bash
DIRECTORY="/home/pacRIS/backups"
if [ ! -d "$DIRECTORY" ] 
then
echo "Directory $DIRECTORY does not exist"
echo "creating directory witinin $DIRECTORY"
sudo mkdir /home/root/backups
else
echo "Directory $DIRECTORY exists"
echo "Proceeding with backups"
sudo chmod -R 777 /home/root/backups	
sudo rm -r /home/root/backups/*	
fi

echo ......................Creating PACRIS BACKUPS..................
echo .........STEP1: BACKING UP T geonodeGeoserver AND geonodeUploadedDocuments DIRECTORIES..........
sudo tar -czvf /home/root/backups/PacRIS_geoserverDataBackup.tar.gz /usr/share/geoserver/data/
sudo tar -czvf /home/root/backups/PacRIS_geonodeUploadedDocumentsBackup.tar.gz  /var/www/geonode/uploaded/documents
echo "Completed backups of directores geoserverdata directory and uploaded documents"
echo .........STEP2: BACKUP GEONODE AND GEONODE_DATA POSTGRES DATABASES.........
sudo -u postgres -i pg_dump -c -Fc geonode > /home/root/backups/PacRIS_geonodeDB.backup
sudo -u postgres -i pg_dump -c -Fc geonode_data > /home/root/backups/PacRIS_geonode_dataDB.backup
echo "Completed backups of Postgres databases"
sudo chmod -R 777 /home/root/backups
echo Backup Completed.

