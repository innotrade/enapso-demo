# ENAPSO Free Platform Demo

This repository contains demo files and setup scripts for the ENAPSO free platform, allowing you to quickly set up and explore the capabilities of the platform.

## Prerequisites

Before running the setup scripts, ensure that you have the following prerequisites:

- Docker installed and running on your machine (version 20.10 or above)
- Internet connection to pull the Docker image
- Credentials for the ENAPSO free platform (username and access token)

## Running the ENAPSO Free Platform

1. Open your command prompt or terminal.

2. Log in to the Docker registry using the following command:
   ```
   docker login registry.innotrade.com -u [username] -p [Personal Access Token]
   ```
   Replace `[username]` and `[Personal Access Token]` with your ENAPSO free platform credentials.

3. Pull the latest version of the ENAPSO free platform Docker image:
   ```
   docker pull registry.innotrade.com/innotrade/enapso-together-free
   ```

4. Run the Docker container:
   ```
   docker run -p 80:80 registry.innotrade.com/innotrade/enapso-together-free
   ```
   This command maps the container's port 80 to your local machine's port 80.

   If you encounter a port conflict, you can map the container's port to a different port on your host. For example:
   ```
   docker run -p 8080:80 registry.innotrade.com/innotrade/enapso-together-free
   ```
   In this case, you would access the platform via `http://localhost:8080`.

5. Verify that the Docker container is running correctly by accessing the platform in your web browser:
   - If you used the default port mapping: `http://localhost`
   - If you used a different port (e.g., 8080): `http://localhost:8080`

## Running the Setup Scripts

The setup scripts automate the process of uploading the ontology, demo data, creating CRUD templates, and setting up REST routes for the ENAPSO free platform.

### For macOS

1. Open a terminal and navigate to the `scripts` directory of this repository.

2. Run the setup script:
   ```
   ./setup_enapso_media_mac.sh
   ```

3. The script will perform the following steps:
   - Check if the ontology and demo data files exist
   - Upload the ontology file
   - Upload the demo data file
   - Create CRUD templates
   - Create REST routes

4. If all steps are successful, the script will display "Setup complete!" message.

### For Windows

1. Open a command prompt and navigate to the `scripts` directory of this repository.

2. Run the setup script:
   ```
   setup_enapso_media_windows.bat
   ```

3. The script will perform the same steps as the macOS version:
   - Check if the ontology and demo data files exist
   - Upload the ontology file
   - Upload the demo data file
   - Create CRUD templates
   - Create REST routes

4. If all steps are successful, the script will display "Setup complete!" message.

After running the setup scripts, you can explore the ENAPSO free platform and interact with the uploaded ontology and demo data using the generated CRUD templates and REST routes.

If you encounter any issues or have questions, please refer to the documentation or contact the ENAPSO support team.