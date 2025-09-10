FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS base
WORKDIR /app

# Copy project metadata first for caching
COPY pyproject.toml README.md ./
# COPY uv.lock ./  # (add when you introduce locking)

# Install deps (no dev) – fallback if lock not present
RUN uv sync --no-dev --frozen || uv sync --no-dev

# Copy source
COPY main.py ./

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
