#!/bin/bash

ontology_file="ebucoreplus.owl"
demo_data_file="editorialObject_demoData.ttl"

echo "Checking if ontology file exists..."
if [ ! -f "../ontologies/$ontology_file" ]; then
  echo "Ontology file ../ontologies/$ontology_file not found. Please make sure the file exists."
  exit 1
fi

echo "Checking if demo data file exists..."
if [ ! -f "../demo-data/$demo_data_file" ]; then
  echo "Demo data file ../demo-data/$demo_data_file not found. Please make sure the file exists."
  exit 1
fi

echo "Uploading ontology file: $ontology_file"
cd ../ontologies
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: multipart/form-data" -F "fileName=@$ontology_file" -F "format=text/turle" -F "baseIRI=http://www.ebu.ch/metadata/ontologies/ebucoreplus#" -F "context=http://www.ebu.ch/metadata/ontologies/ebucoreplus" "http://localhost/enapso-dev/graphdb-management/v1/upload-ontology-from-file")
cd ../scripts

if [ "$response" == "200" ] || [ "$response" == "201" ]; then
  echo "Ontology upload succeeded"
else
  echo "Ontology upload failed with status code $response"
  exit 1
fi
echo "-------------------"

echo "Uploading demo data file: $demo_data_file"
cd ../demo-data
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: multipart/form-data" -F "fileName=@$demo_data_file" -F "format=text/turtle" -F "baseIRI=http://www.ebu.ch/metadata/ontologies/ebucoreplus#" -F "context=http://www.ebu.ch/metadata/ontologies/ebucoreplus/demodata" "http://localhost/enapso-dev/graphdb-management/v1/upload-ontology-from-file")
cd ../scripts

if [ "$response" == "200" ] || [ "$response" == "201" ]; then
  echo "Demo data upload succeeded"
else
  echo "Demo data upload failed with status code $response"
  exit 1
fi
echo "-------------------"

echo "Creating CRUD templates..."
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d '{"cls": "http://www.ebu.ch/metadata/ontologies/ebucoreplus#EditorialObject"}' "http://localhost/enapso-dev/view-management/v1/create-crud-sparql-template-4-class")

if [ "$response" == "200" ] || [ "$response" == "201" ]; then
  echo "CRUD template creation succeeded"
else
  echo "CRUD template creation failed with status code $response"
  exit 1
fi
echo "-------------------"

echo "Creating REST routes..."
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" -d '{"records": [{"endpoint": "editorialObject", "baseURL": "/v1", "endpointConfig": [{"method": "get", "template": "readEditorialObject"}, {"method": "post", "template": "createEditorialObject"}, {"method": "patch", "template": "updateEditorialObject"}, {"method": "delete", "template": "deleteEditorialObject"}]}]}' "http://localhost/enapso-dev/view-management/v1/create-endpoint-4-template")

if [ "$response" == "200" ] || [ "$response" == "201" ]; then
  echo "REST route creation succeeded"
else
  echo "REST route creation failed with status code $response"
  exit 1
fi
echo "-------------------"

echo "Setup complete!"