# flask.Dockerfile
FROM python:3.12-slim

# Set the working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libpng-dev \
    libpq-dev \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies and install
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy Flask application
COPY api ./api

ENV FLASK_ENV production

EXPOSE 5328

CMD ["python", "api/index.py"]