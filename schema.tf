# # # Injecting the Schema
resource "null_resource" "mongod-schema" {
  
  depends_on  =  [aws_docdb_cluster.main]  # Ensuring thisschema load will happen only after the cration of doc db
  provisioner "local-exec" {
    command = <<EOF
    cd /tmp 
    curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
    unzip -o mongodb.zip 
    cd mongodb-main 
    mongo --ssl --host ${aws_docdb_cluster.main.endpoint}:27017 --sslCAFile /home/centos/rds-combined-ca-bundle.pem --username admin1 --password roboshop1 < catalogue.js
    mongo --ssl --host  ${aws_docdb_cluster.main.endpoint}:27017 --sslCAFile /home/centos/rds-combined-ca-bundle.pem --username admin1 --password roboshop1 < users.js
EOF
  }
}