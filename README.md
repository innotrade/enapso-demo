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

5. Open a new terminal and clone this repository to your local machine:

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
     cd scripts
     chmod +x setup_enapso_media.sh
     ./setup_enapso_media.sh
     ```

   - For Windows:

     ```
     cd scripts
     setup_enapso_media_windows.bat
     ```

   The setup script will perform the following tasks:
   - Upload the ontology file (`ontologies/ebucoreplus.owl`)
   - Upload the demo data file (`demo-data/editorialObject_demoData.ttl`)
   - Create CRUD templates for the `EditorialObject` class
   - Set up REST routes for the CRUD operations

8. Once the setup script completes successfully, you can access the Swagger documentation for ENAPSO free services through your web browser:

   | Service Name | Description | Access Link |
   | --- | --- | --- |
   | View Management Service | API documentation for View Management | [View Management Docs](http://localhost/enapso-dev/view-management/v1/api-docs/) |
   | GraphDB Management Service | API documentation for GraphDB Management | [GraphDB Management Docs](http://localhost/enapso-dev/graphdb-management/v1/api-docs/) |

For more detailed documentation and information about the ENAPSO platform, please refer to the [Setting Up ENAPSO media free](https://innotrade.atlassian.net/wiki/spaces/ENAPTOSOGETHER/pages/2232451073/Setting+Up+ENAPSO+media+free) page on the ENAPSO documentation wiki.

## Repository Structure

The repository is organized as follows:

- `ontologies/`: Contains the ontology file (`ebucoreplus.owl`)
- `demo-data/`: Contains the demo data file (`editorialObject_demoData.ttl`)
- `scripts/`: Contains the setup scripts for macOS/Linux and Windows

## Troubleshooting

If you encounter any issues during the setup process, please refer to the ENAPSO documentation or contact the ENAPSO support team for assistance.
