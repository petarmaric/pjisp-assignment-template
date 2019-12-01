FROM python:2.7-slim

WORKDIR /app
ARG DEBIAN_FRONTEND=noninteractive
ARG PIP_NO_CACHE_DIR=0

ENTRYPOINT ["make"]

RUN set -x \
    # Update the Ubuntu package index
    && apt-get update \
    # Install the required Ubuntu packages
    && apt-get install -y \
            fontconfig \
            python-pip \
    # Clean the APT cache to reduce Docker image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # Install Pipenv
    && pip install pipenv

# Install the required Python packages
COPY Pipfile Pipfile.lock ./
RUN pipenv install --deploy --system

