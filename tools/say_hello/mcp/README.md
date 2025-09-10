Say Hello MCP (Remote HTTP Streaming)
====================================

Minimal FastMCP server exposing a single streaming tool `say_hello` that returns
``Hello <name>!``. Designed to demonstrate placing Azure API Management in front of
an MCP server (remote HTTP transport, not stdio) so AI agent clients can access it
over the network.

Key Features
------------
* FastMCP v2 server (`fastmcp==2.11.3`) – pinned for deterministic workshop behavior.
* Remote HTTP transport (run via `fastmcp run ... --transport http`).
* Streaming output: characters are yielded incrementally before the final value.
* uv used for dependency management & execution.

Run Locally (HTTP)
------------------
```bash
uv run fastmcp run main.py --transport http --host 0.0.0.0 --port 8765
```

Test with FastMCP Client
------------------------
```bash
uv run python - <<'PY'
import asyncio
from fastmcp import Client

async def main():
	client = Client("http://localhost:8765")
	async with client:
		result = await client.call_tool("say_hello", {"name": "Azure"})
		print(result.data)  # Expect ['Hello Azure!']
asyncio.run(main())
PY
```

Basic Curl (non‑protocol) Note
------------------------------
Direct curl against FastMCP protocol endpoints is not very illustrative because
the protocol expects an MCP client. Prefer using the FastMCP client above or an
MCP‑aware application (Claude Desktop, Cursor, etc.).

Docker
------
```bash
docker build -t say-hello-mcp .
docker run --rm -p 8765:8765 say-hello-mcp
```

Behind API Management
---------------------
Publish the container and register its `/` base URL with APIM. Expose only the
MCP endpoint path (root) and apply policies (auth, rate limiting, logging) while
keeping streaming enabled.

Fallback Stdio Run (not for APIM demo)
--------------------------------------
```bash
uv run say-hello-mcp-stdio
```

License: MIT
