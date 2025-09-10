Say Hello REST API (FastAPI)
================================

Simple demo service to showcase using Azure API Management as a facade for AI agents. It exposes a single endpoint returning a personalized greeting.

Endpoint
--------
GET /hello?name=Alice -> {"message": "Hello Alice!"}

Local Run (uv)
--------------
```bash
uv run uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Quick test:
```bash
curl "http://localhost:8000/hello?name=Azure"
```

Project scripts:
```bash
uv run say-hello-api  # runs uvicorn without reload
```

Docker
------
Image uses the official uv base for fast installs.
```bash
docker build -t say-hello-api .
docker run --rm -p 8000:8000 say-hello-api
curl "http://localhost:8000/hello?name=World"
```

Why uv?
-------
We use uv for fast, reproducible dependency management. The Dockerfile performs `uv sync` (adding `--frozen` automatically once a lock file is committed) and starts the service with `uv run` so dependency resolution stays consistent across local and container environments.

Testing (optional):
```bash
uv run pytest -q
```

License: MIT
