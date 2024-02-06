const axios = require("axios");
const FormData = require("form-data");
const fs = require("fs");
const config = require("../config.json"); // Import configuration

// Self-invoking function
(async () => {
  // function body remains the same
  await uploadOntology(config.uploadOntologyInfo);
  await createTemplate(config.templateData);
  await createVariable(config.variableData);
  await assignVariableToTemplate(
    config.templateData.iri,
    config.variableData.iri
  );
  await executeTemplate(config.templateData.name, config.executeVariable);
})();

// Upload Ontology function
async function uploadOntology(data) {
  // function body remains the same
  const formData = new FormData();
  formData.append("fileName", fs.createReadStream(data.fileName));
  formData.append("format", data.format);
  formData.append("context", data.context);
  try {
    const response = await axios.post(
      `${config.host}/enapso-dev/graphdb-management/v1/upload-ontology-from-file`,
      formData,
      { headers: formData.getHeaders() }
    );
    console.log("Upload successful:", response.data);
  } catch (error) {
    console.error("Upload failed:", error.response.data);
  }
}

// Create Template function
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

// Create Variable
async function createVariable(data) {
  try {
    const response = await axios.post(
      `${config.host}/enapso-dev/view-management/v1/create-variable`,
      { records: [data] }
    );
    console.log("Template creation successful:", response.data);
  } catch (error) {
    console.error("Template creation failed:", error.response.data);
  }
}

// Assign Variable to template
async function assignVariableToTemplate(templateIRI, variableIRI) {
  try {
    const response = await axios.post(
      `${config.host}/enapso-dev/view-management/v1/add-variable-to-template`,
      { template: templateIRI, variable: variableIRI }
    );
    console.log("Template creation successful:", response.data);
  } catch (error) {
    console.error("Template creation failed:", error.response.data);
  }
}

// Execute Template function
async function executeTemplate(template, parmas) {
  try {
    const response = await axios.post(
      `${config.host}/enapso-dev/view-management/v1/execute-template-by-name`,
      { templateName: template, variables: parmas }
    );
    console.log("Template response:", response.data);
  } catch (error) {
    console.error("Template creation failed:", error.response.data);
  }
}
