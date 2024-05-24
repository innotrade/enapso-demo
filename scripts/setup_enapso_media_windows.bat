@echo off

set ontology_file=ebucoreplus.owl
set demo_data_file=editorialObject_demoData.ttl

echo Checking if ontology file exists...
if not exist "..\ontologies\%ontology_file%" (
  echo Ontology file ..\ontologies\%ontology_file% not found. Please make sure the file exists.
  exit /b 1
)

echo Checking if demo data file exists...
if not exist "..\demo-data\%demo_data_file%" (
  echo Demo data file ..\demo-data\%demo_data_file% not found. Please make sure the file exists.
  exit /b 1
)
echo -------------------


echo Uploading ontology file: %ontology_file%
set "response="
cd ..\ontologies
for /f "delims=" %%a in ('curl -s -o nul -w "%%{http_code}" -X POST -H "Content-Type: multipart/form-data" -F "fileName=@%ontology_file%" -F "format=text/turle" -F "baseIRI=http://www.ebu.ch/metadata/ontologies/ebucoreplus#" -F "context=http://www.ebu.ch/metadata/ontologies/ebucoreplus" "http://localhost/enapso-dev/graphdb-management/v1/upload-ontology-from-file"') do set "response=%%a"
cd ..\scripts

if "%response%"=="200" (
  echo Ontology upload succeeded
) else if "%response%"=="201" (
  echo Ontology upload succeeded
) else (
  echo Ontology upload failed with status code %response%
  exit /b 1
)
echo -------------------

echo Uploading demo data file: %demo_data_file%
set "response="
cd ..\demo-data
for /f "delims=" %%a in ('curl -s -o nul -w "%%{http_code}" -X POST -H "Content-Type: multipart/form-data" -F "fileName=@%demo_data_file%" -F "format=text/turtle" -F "baseIRI=http://www.ebu.ch/metadata/ontologies/ebucoreplus#" -F "context=http://www.ebu.ch/metadata/ontologies/ebucoreplus/demodata" "http://localhost/enapso-dev/graphdb-management/v1/upload-ontology-from-file"') do set "response=%%a"
cd ..\scripts

if "%response%"=="200" (
  echo Demo data upload succeeded
) else if "%response%"=="201" (
  echo Demo data upload succeeded
) else (
  echo Demo data upload failed with status code %response%
  exit /b 1
)
echo -------------------

echo Creating CRUD templates...
set "response="
for /f "delims=" %%a in ('curl -s -o nul -w "%%{http_code}" -X POST -H "Content-Type: application/json" -d "{\"cls\": \"http://www.ebu.ch/metadata/ontologies/ebucoreplus#EditorialObject\"}" "http://localhost/enapso-dev/view-management/v1/create-crud-sparql-template-4-class"') do set "response=%%a"

if "%response%"=="200" (
  echo CRUD template creation succeeded
) else if "%response%"=="201" (
  echo CRUD template creation succeeded
) else (
  echo CRUD template creation failed with status code %response%
  exit /b 1
)
echo -------------------

echo Creating REST routes...
set "response="
for /f "delims=" %%a in ('curl -s -o nul -w "%%{http_code}" -X POST -H "Content-Type: application/json" -d "{\"records\": [{\"endpoint\": \"editorialObject\", \"baseURL\": \"/v1\", \"endpointConfig\": [{\"method\": \"get\", \"template\": \"readEditorialObject\"}, {\"method\": \"post\", \"template\": \"createEditorialObject\"}, {\"method\": \"patch\", \"template\": \"updateEditorialObject\"}, {\"method\": \"delete\", \"template\": \"deleteEditorialObject\"}]}]}" "http://localhost/enapso-dev/view-management/v1/create-endpoint-4-template"') do set "response=%%a"

if "%response%"=="200" (
  echo REST route creation succeeded
) else if "%response%"=="201" (
  echo REST route creation succeeded
) else (
  echo REST route creation failed with status code %response%
  exit /b 1
)
echo -------------------

echo Setup complete!