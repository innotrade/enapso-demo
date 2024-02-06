# ENAPSO Together Services - Comprehensive User Guide

Welcome to the comprehensive guide on utilizing ENAPSO Together Services. This guide is designed to assist developers in integrating uploading ontology, SPARQL template creation, and execution functionalities into their projects.

## Prerequisites

Before you begin, ensure you have the following:

- **Node.js**: Install the latest version from [nodejs.org](https://nodejs.org/).
- **npm (Node Package Manager)**: Comes with Node.js, used for managing dependencies.
- **Basic JavaScript Knowledge**: Familiarity with JavaScript and asynchronous programming.
- **Understanding of Ontologies and SPARQL**: Knowledge of ontological models and SPARQL queries.
- **ENAPSO Host Access**: Access to an ENAPSO Together host URL where services are running.

Verify Node.js and npm installations by running `node -v` and `npm -v` in your terminal.

## Setup and Installation

1. **Create a Project Directory**: Make a new directory for your project and navigate into it.
2. **Initialize npm**: Run `npm init -y` to create a `package.json` file.
3. **Install Dependencies**: Install Axios and Form-Data libraries by running:
   ```sh
   npm install axios form-data
   ```
4. **Configuration File**: Create a `config.json` file in your project directory with the following structure:
```json
{
  "host": "http://localhost",
  "uploadOntologyInfo": {
    "fileName": "./ontologies/EnapsoTest.owl",
    "format": "application/rdf+xml",
    "context": "http://ont.enapso.com/test"
  },
  "templateData": {
    "name": "readPredicateValues",
    "iri": "http://ont.enapso.com/sparql-template#SPARQLTemplate_4e580dfd-1ecc-4f54-9986-51202b7416c6",
    "template": "`select ?iri ?predicateValue where { ?iri ${predicate} ?predicateValue. }`"
  },
  "variableData": {
    "name": "predicate",
    "iri": "http://ont.enapso.com/sparql-template#TemplateVariable_4e580dfd-1ecc-4f54-9986-23456788765"
  },
  "executeVariable": {
    "predicate": "http://www.w3.org/2000/01/rdf-schema#label"
  }
}
```

- **`host`**: The URL of the ENAPSO host where the services are running. Replace `"http://localhost"` with the actual host URL.

- **`uploadOntologyInfo`**: Information related to uploading an ontology file.
  - `fileName`: The path to the ontology file to be uploaded.
  - `format`: The format of the ontology file, typically `"application/rdf+xml"`.
  - `context`: The context or namespace for the ontology, such as `"http://ont.enapso.com/test"`.

- **`templateData`**: Data for creating a SPARQL template.
  - `name`: The name of the SPARQL template, e.g., `"readPredicateValues"`.
  - `iri`: The IRI (Internationalized Resource Identifier) for the template.
  - `template`: The SPARQL query template with `${predicate}` as a placeholder for a variable.

- **`variableData`**: Data for creating a template variable.
  - `name`: The name of the variable, e.g., `"predicate"`.
  - `iri`: The IRI for the template variable.

- **`executeVariable`**: Variable data used when executing the SPARQL template.
  - `"predicate"`: The value assigned to the `"predicate"` variable when executing the template, e.g., `"http://www.w3.org/2000/01/rdf-schema#label"`.

These configurations represent an example setup for using ENAPSO Together Services, where you upload an ontology, create a SPARQL template, define a template variable, and execute the template with a specific variable value. Users should replace the placeholder values with their own ontology, template, and variable details as needed.

## Features and Implementation

### 1. Uploading Ontologies

This feature allows you to upload ontology files to the GraphDB repository.
- **Parameters**: `data` from `config.uploadOntologyInfo`
- **Dependencies**: Axios, Form-Data, fs, config
- **Sourcecode**:

```javascript
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');
const config = require('./config.json');

async function uploadOntology(data) {
  const formData = new FormData();
  formData.append('fileName', fs.createReadStream(data.fileName));
  formData.append('format', data.format);
  formData.append('context', data.context);

  try {
    const response = await axios.post(`${config.host}/enapso-dev/graphdb-management/v1/upload-ontology-from-file`, formData, {
      headers: formData.getHeaders(),
    });
    console.log('Upload successful:', response.data);
  } catch (error) {
    console.error('Upload failed:', error.response?.data || error.message);
  }
}


```

### 2. Creating Templates

Define SPARQL queries with placeholders for variables to create reusable query templates.

- **Parameters**: `data` from `config.templateData`
- **Dependencies**: Axios, config
- **SourceCode**:
  
```javascript
const axios = require("axios");
const config = require("./config.json");

async function createTemplate(data) {
    try {
        const response = await axios.post(
            `${config.host}/enapso-dev/view-management/v1/create-template`, 
            { records: [data] }
        );
        console.log("Template creation successful:", response.data);
    } catch (error) {
        console.error("Template creation failed:", error.response.data);
    }
}

  

```

### 3. Creating Variables

Define variables to dynamically insert values into your SPARQL query templates.
- **Parameters**: `data` from `config.variableData`
- **Dependencies**: Axios, config
- **SourceCode**:

```javascript
const axios = require("axios");
const config = require("./config.json");

async function createVariable(data) {
    try {
        const response = await axios.post(
            `${config.host}/enapso-dev/view-management/v1/create-variable`,
            { records: [data] }
        );
        console.log("Variable creation successful:", response.data);
    } catch (error) {
        console.error("Variable creation failed:", error.response.data);
    }
}


```

### 4. Assigning Variables to Templates

Link variables to their corresponding placeholders within SPARQL template.
- **Parameters**: `templateIRI` and `variableIRI` from `config.templateData.iri` and `config.variableData.iri`
- **Dependencies**: Axios, config
- **SourceCode**:
```javascript
const axios = require("axios");
const config = require("./config.json");

async function assignVariableToTemplate(templateIRI, variableIRI) {
    try {
        const response = await axios.post(
            `${config.host}/enapso-dev/view-management/v1/add-variable-to-template`, 
            {
                template: templateIRI, 
                variable: variableIRI
            }
        );
        console.log("Variable assignment successful:", response.data);
    } catch (error) {
        console.error("Variable assignment failed:", error.response.data);
    }
}


```

### 5. Executing Templates

Run templates with specified variable values to perform dynamic SPARQL queries.

- **Parameters**: `template` from `config.templateData.name`, `params` from `config.executeVariable`
- **Dependencies**: Axios, config
- **SourceCode**:
```javascript
const axios = require('axios');
const config = require('./config.json');

async function executeTemplate(template, params) {
  try {
    const response = await axios.post(`${config.host}/enapso-dev/view-management/v1/execute-template-by-name`, {
      templateName: template,
      variables: params
    });
    console.log('Template execution successful:', response.data);
  } catch (error) {
    console.error('Template execution failed:', error.response?.data);
  }
}


```

### Running the Demo

Integrate the functions into a self-invoking asynchronous method within your main script file (e.g., `enapso_demo.js`):

```javascript
const config = require("./config.json");

(async () => {
  await uploadOntology(config.uploadOntologyInfo);
  await createTemplate(config.templateData);
  await createVariable(config.variableData);
  await assignVariableToTemplate(
    config.templateData.iri,
    config.variableData.iri
  );
  await executeTemplate(config.templateData.name, config.executeVariable);

  console.log("ENAPSO Together Services Demo Completed Successfully");
})();
```

### Execution

1. Ensure your `config.json` is properly set up with your specific configurations.
2. Place all feature functions and the self-invoking method in your main JavaScript file.
3. Run the demo by executing `node enapso_demo.js` in your terminal.

This comprehensive guide, including configuration details, feature descriptions, and source code snippets, equips you with everything needed to leverage ENAPSO Together Services in your projects effectively.
