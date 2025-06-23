# Use official Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install dependencies (update pip + install from requirements)
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Expose port required by Cloud Run
EXPOSE 8080

# Set PORT environment variable (used by Gunicorn)
ENV PORT=8080

# Use Gunicorn to run the Flask app
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
