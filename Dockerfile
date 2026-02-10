FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application contents
COPY service/ ./service/

# Create and switch a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app

# Expose port 8080 in which the application will run
EXPOSE 8080
# Default command the container will run when starts
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
