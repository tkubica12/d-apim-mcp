FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS base
WORKDIR /app

COPY pyproject.toml README.md ./
# COPY uv.lock ./  # (add when locking dependencies)
RUN uv sync --no-dev --frozen || uv sync --no-dev

COPY main.py ./

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

EXPOSE 8765

# Use FastMCP CLI with remote HTTP transport (streaming capable)
CMD ["uv", "run", "fastmcp", "run", "main.py", "--transport", "http", "--host", "0.0.0.0", "--port", "8765"]
