# Use official Python slim image for smaller size   
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Install dependencies with error logging and ensure pip is up-to-date
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt || { echo "Failed to install dependencies"; exit 1; }

# Copy all files (including app.py and index.html)
COPY . .

# Expose port (Cloud Run requires 8080)
EXPOSE 8080

# Set environment variable for Cloud Run
ENV PORT=8080

# Run the application
CMD exec python app.py
