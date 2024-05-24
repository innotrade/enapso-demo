# ENAPSO Media Demo

This repository contains scripts and documentation for setting up and running the ENAPSO media demo using the ENAPSO free platform.

## Prerequisites

Before running the setup scripts, ensure that you have the following:

- Docker installed and running on your machine
- Docker Compose installed
- Git installed

## Getting Started

1. Clone this repository to your local machine:

   ```
   git clone https://github.com/innotrade/enapso-demo.git
   ```

2. Navigate to the cloned repository:

   ```
   cd enapso-demo
   ```

3. Pull the ENAPSO free platform Docker image:

   ```
   docker pull registry.innotrade.com/innotrade/enapso-together-free
   ```

4. Run the ENAPSO free platform using Docker Compose:

   ```
   docker-compose up -d
   ```

   This command will start the ENAPSO free platform in detached mode.

5. Wait for the platform to start up. You can check the status of the containers using:

   ```
   docker-compose ps
   ```

   Once the platform is up and running, proceed to the next step.

6. Run the setup script for your operating system:

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

7. Once the setup script completes successfully, you can access the ENAPSO media demo using the following URLs:

   - ENAPSO Platform: `http://localhost/enapso-dev/`
   - GraphDB Management API: `http://localhost/enapso-dev/graphdb-management/`
   - View Management API: `http://localhost/enapso-dev/view-management/`

## Repository Structure

The repository is organized as follows:

- `ontologies/`: Contains the ontology file (`ebucoreplus_ontology.ttl`)
- `demo-data/`: Contains the demo data file (`editorialObject_demoData.ttl`)
- `scripts/`: Contains the setup scripts for macOS/Linux and Windows
- `docker-compose.yml`: Docker Compose configuration file for running the ENAPSO free platform

## Troubleshooting

If you encounter any issues during the setup process, please refer to the ENAPSO documentation or contact the ENAPSO support team for assistance.
