# ENAPSO Media Demo

This repository contains scripts and documentation for setting up and running the ENAPSO media demo using the ENAPSO free platform.

## Prerequisites

Before running the setup scripts, ensure that you have the following:

- Docker installed and running on your machine (version 20.10 or above)
  - To check your Docker version, open your command prompt or terminal and enter: `docker --version`
- Internet connection to pull the Docker image from the repository
- Credentials for the ENAPSO free platform (see instructions below)

## Getting Started

1. Request your username and access token for the ENAPSO free platform:
   - Send an email to support@innotrade.de with the subject line "Request for Credentials"
   - In the email body, include a message similar to the following:
     ```
     Dear Support Team,
     
     I am interested in accessing the ENAPSO free platform powered by Innotrade and would like to request a username and access token.
     
     Please let me know if any additional information is required.
     
     Thank you!
     
     Best regards,
     [Your Name]
     ```
   - Wait for a response from the support team with your credentials.

2. Log in to the Docker registry using the provided credentials:

   ```
   docker login registry.innotrade.com -u [username] -p [access_token]
   ```

   Replace `[username]` with your username and `[access_token]` with your personal access token.

3. Pull the latest version of the ENAPSO free platform Docker image:

   ```
   docker pull registry.innotrade.com/innotrade/enapso-together-free
   ```

   Note: When running the pull command, if an image is already running and you pull the latest one, it will overwrite existing data in the knowledge graph repository, resetting it to the default state. To avoid losing your data, create a backup before pulling the latest image and restore your data afterward.

4. Run the Docker container to deploy the platform locally:

   ```
   docker run -p 80:80 registry.innotrade.com/innotrade/enapso-together-free
   ```

   This command maps the container's port 80 to your local machine's port 80.

   If you encounter a port conflict, you can map the container's internal port (80) to a different port on your host. For example, to use port 8080:

   ```
   docker run -p 8080:80 registry.innotrade.com/innotrade/enapso-together-free
   ```

5. Clone this repository to your local machine:

   ```
   git clone https://github.com/innotrade/enapso-demo.git
   ```

6. Navigate to the cloned repository:

   ```
   cd enapso-demo
   ```

7. Run the setup script for your operating system:

   - For macOS and Linux:

     ```
     chmod +x scripts/setup_enapso_media.sh
     ./scripts/setup_enapso_media.sh
     ```

   - For Windows:

     ```
     scripts\setup_enapso_media.bat
     ```

   The setup script will perform the following tasks:
   - Upload the ontology file (`ontologies/ebucoreplus_ontology.ttl`)
   - Upload the demo data file (`demo-data/editorialObject_demoData.ttl`)
   - Create CRUD templates for the `EditorialObject` class
   - Set up REST routes for the CRUD operations

8. Once the setup script completes successfully, you can access the ENAPSO media demo using the following URLs:

   - ENAPSO Platform: `http://localhost/enapso-dev/`
   - GraphDB Management API: `http://localhost/enapso-dev/graphdb-management/`
   - View Management API: `http://localhost/enapso-dev/view-management/`

## Repository Structure

The repository is organized as follows:

- `ontologies/`: Contains the ontology file (`ebucoreplus_ontology.ttl`)
- `demo-data/`: Contains the demo data file (`editorialObject_demoData.ttl`)
- `scripts/`: Contains the setup scripts for macOS/Linux and Windows

## Troubleshooting

If you encounter any issues during the setup process, please refer to the ENAPSO documentation or contact the ENAPSO support team for assistance.
