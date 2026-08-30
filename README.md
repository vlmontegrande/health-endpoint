# Health Endpoint

This is a health endpoint for my server. I have a small Node server in a container running on my server that returns JSON of the server's CPU usage, RAM usage, disk space, and other metrics. These metrics are taken using a bash script.

## Build and deploy pipeline

I have a Github Actions pipeline set up. On push to the repo, the pipeline checks out the code, logs in to Docker Hub, builds and pushes the image. A second job then ssh's into the server by installing cloudflared and setting up the ssh config. It then copies the Docker Compose file to the server and pulls the new image that was pushed by the build job.

## Docker image

The container runs a small Express server inside. The server runs the server health bash script via node.spawn(). Since the container has to read files and execute commands from the machine's system, a volume is set up so that the container can read the server's metrics.
