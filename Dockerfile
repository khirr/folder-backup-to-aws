# Use a Debian-based image as a base image
FROM debian:bullseye-slim

# Install required packages
RUN apt-get update && \
    apt-get install -y wget zip python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install AWS CLI in the virtual environment
RUN pip install --upgrade pip && \
    pip install awscli awscli_plugin_endpoint

# Copy AWS configuration files
COPY ./config/config /root/.aws/config
COPY ./config/credentials /root/.aws/credentials

# Add the backup script
COPY backup.sh /usr/local/bin/backup.sh

# Make the script executable
RUN chmod +x /usr/local/bin/backup.sh

# Set the command to run the backup script
CMD ["sh", "/usr/local/bin/backup.sh"]
