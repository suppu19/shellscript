#!/bin/bash


# set the backup directory path
backup_dir="/opt/"


# set the name of the backup file
backup_file="mybackup_$(date +"%Y%m%d_%H%M%S").tar.gz"


# create the backup file
tar -czf "$backup_dir/$backup_file" /root/backup_sysfiles


# check if the backup file was created successfully
if [ -f "$backup_dir/$backup_file" ]; then
  echo "Backup created successfully!"
else
  echo "Error: Backup creation failed!"
  exit 1
fi
