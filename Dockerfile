# FROM ubuntu:16.04
FROM python:2-slim

WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive PIP_NO_CACHE_DIR=0
ENTRYPOINT ["make"]

RUN set -ex \
	# Update the Ubuntu package index
	&& apt-get update \
	# Install the required Ubuntu packages
	&& apt-get install -y fontconfig build-essential \
	# Clean the APT cache to reduce Docker image size
	&& apt-get clean \
	# Install Pipenv
	&& pip install pipenv

# Install the required Python packages
COPY Pipfile Pipfile.lock ./
RUN pipenv install --deploy --system

