# syntax=docker/dockerfile:1

FROM python:3.11-slim

# Environment vars for better Python/Docker behavior
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on

WORKDIR /app

# Install minimal system deps (gcc for potential numpy/sklearn compilation)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy & install deps first (max caching)
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy app code + model
COPY app/ .

# Render expects the app to bind to $PORT (defaults to 10000)
# Production: Gunicorn + Uvicorn workers (recommended by FastAPI & Render docs 2025+)
# --workers: start low (2-4); increase on paid plans based on CPU cores
CMD ["gunicorn", "main:app", \
     "--workers", "3", \
     "--worker-class", "uvicorn.workers.UvicornWorker", \
     "--bind", "0.0.0.0:$PORT", \
     "--timeout", "120", \
     "--log-level", "info"]

# Optional: if you prefer plain uvicorn (simpler but less robust for production)
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT", "--workers", "4"]