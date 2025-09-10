"""Say Hello MCP server (simplified synchronous tool).

Exposes a single tool `greet` (and legacy alias `say_hello`) returning:
    "Hello, <name>!"

Usage (remote HTTP transport default):
    uv run fastmcp run main.py --transport http --host 0.0.0.0 --port 8765

Quick client test:
    uv run python - <<'PY'
    import asyncio
    from fastmcp import Client

    async def main():
        client = Client("http://localhost:8765")
        async with client:
            result = await client.call_tool("greet", {"name": "Azure"})
            print(result.data)
    asyncio.run(main())
    PY

Running `python main.py` directly starts an HTTP server (not stdio) for convenience.
"""

from __future__ import annotations

from fastmcp import FastMCP
import os
import uvicorn

mcp = FastMCP(name="say-hello-mcp", version="0.1.0")


@mcp.tool()
def greet(name: str) -> str:
    """Return a friendly greeting."""
    return f"Hello {name}!"

if __name__ == "__main__":
    mcp.run(transport="http")
