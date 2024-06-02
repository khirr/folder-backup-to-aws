#!/bin/bash

#### Replace config vars
sed -i "s,_AWS_REGION_,${AWS_REGION},g" /root/.aws/config

#### Replace credentials vars
sed -i "s,_AWS_ACCESS_KEY_,${AWS_ACCESS_KEY},g" /root/.aws/credentials
sed -i "s,_AWS_SECRET_KEY_,${AWS_SECRET_KEY},g" /root/.aws/credentials

#### Generate Backup

echo "Compressing backup..."

if [ -z "${BACKUP_PREFIX}" ]; then
  fileName=`date +%Y-%m-%d-%H%M%S.zip`
else
  fileName=`date +%Y-%m-%d-%H%M%S.zip`
  fileName="${BACKUP_PREFIX}-${fileName}"
fi

zip -r $fileName $BACKUP_FOLDER

echo "Compression complete"
echo "Uploading ..."

filePath=`date +%Y/%m/%d`

if [ -z "${AWS_BUCKET_PATH}" ]; then
  filePath="${AWS_BUCKET_PATH}/$filePath"
fi

aws s3 cp $fileName s3://${AWS_BUCKET_NAME}/$filePath/$fileName

echo "Uploaded"
