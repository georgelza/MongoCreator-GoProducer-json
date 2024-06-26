#!/bin/bash

#------------------------------------------------------------------------------
#-- Post/Sink to Local Mongo container

. ./.pwdmongolocal

curl -X POST \
  -H "Content-Type: application/json" \
  --data '
      {"name": "mongo-local-salesbaskets-sink-json",
        "config": {
          "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
          "connection.uri": "'${MONGO_URL}'",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter":"io.confluent.connect.protobuf.ProtobufConverter",
          "value.converter.schema.registry.url":"http://schema-registry:8081",
          "value.converter.schemas.enable": true,
          "database":"MongoCom0",
          "collection":"json_salesbaskets",
          "topics":"json_salesbaskets"
          }
      }
      ' \
  http://localhost:8083/connectors -w "\n"


curl -X POST \
  -H "Content-Type: application/json" \
  --data '
      {"name": "mongo-local-salespayments-sink-json",
        "config": {
          "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
          "connection.uri": "'${MONGO_URL}'",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter":"io.confluent.connect.protobuf.ProtobufConverter",
          "value.converter.schema.registry.url":"http://schema-registry:8081",
          "value.converter.schemas.enable": true,
          "database":"MongoCom0",
          "collection":"json_salespayments",
          "topics":"json_salespayments"
          }
      }
      ' \
  http://localhost:8083/connectors -w "\n"

curl -X POST \
  -H "Content-Type: application/json" \
  --data '
     { "name": "mongo-local-salescompleted-sink-json",
        "config": {
          "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
          "connection.uri": "'${MONGO_URL}'",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter":"io.confluent.connect.protobuf.ProtobufConverter",
          "value.converter.schema.registry.url":"http://schema-registry:8081",
          "value.converter.schemas.enable": true,
          "database":"MongoCom0",
          "collection":"json_salescompleted",
          "topics":"json_salescompleted"
          }
      }
      ' \
  http://localhost:8083/connectors -w "\n"


#------------------------------------------------------------------------------
#-- Post/Sink to Atlas

. ./.pwdmongoatlas


curl -X POST \
  -H "Content-Type: application/json" \
  --data '
     { "name": "mongo-atlas-salesbaskets-sink-json",
        "config": {
          "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
          "connection.uri": "'${MONGO_URL}'",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter":"io.confluent.connect.protobuf.ProtobufConverter",
          "value.converter.schema.registry.url":"http://schema-registry:8081",
          "value.converter.schemas.enable": true,
          "database": "MongoCom0",
          "collection": "json_salesbaskets",
          "topics": "json_salesbaskets"
        }
      } 
      ' \
  http://localhost:8083/connectors -w "\n"


  curl -X POST \
  -H "Content-Type: application/json" \
  --data '
     { "name": "mongo-atlas-salespayments-sink-json",
        "config": {
          "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
          "connection.uri": "'${MONGO_URL}'",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter":"io.confluent.connect.protobuf.ProtobufConverter",
          "value.converter.schema.registry.url":"http://schema-registry:8081",
          "value.converter.schemas.enable": true,
          "database": "MongoCom0",
          "collection": "json_salespayments",
          "topics": "json_salespayments"
        }
      } 
      ' \
  http://localhost:8083/connectors -w "\n"


  curl -X POST \
  -H "Content-Type: application/json" \
  --data '
     { "name": "mongo-atlas-salescompleted-sink-json",
        "config": {
          "connector.class": "com.mongodb.kafka.connect.MongoSinkConnector",
          "connection.uri": "'${MONGO_URL}'",
          "key.converter": "org.apache.kafka.connect.storage.StringConverter",
          "value.converter":"io.confluent.connect.protobuf.ProtobufConverter",
          "value.converter.schema.registry.url":"http://schema-registry:8081",
          "value.converter.schemas.enable": true,
          "database": "MongoCom0",
          "collection": "json_salescompleted",
          "topics": "json_salescompleted"
        }
      } 
      ' \
  http://localhost:8083/connectors -w "\n"

      