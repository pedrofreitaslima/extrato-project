#!/bin/bash
sudo yum -y install java-11
cd /home/ec2-user
wget https://www.openintro.org/data/csv/nycflights.csv
tail -n +2 nycflights.csv > tmp.csv && mv tmp.csv nycflights.csv
wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.12-2.8.1.tgz
tar -xzf kafka_2.12-2.8.1.tgz
cd kafka_2.12-2.8.1/libs
wget https://github.com/aws/aws-msk-iam-auth/releases/download/v1.1.1/aws-msk-iam-auth-1.1.1-all.jar
cd ../bin
echo "security.protocol=SASL_SSL" | sudo tee -a client.properties
echo "sasl.mechanism=AWS_MSK_IAM" | sudo tee -a client.properties
echo "sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;" | sudo tee -a client.properties
echo "sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler" | sudo tee -a client.properties
chown -R ec2-user:ec2-user /home/ec2-user/