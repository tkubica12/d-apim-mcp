"""Say Hello REST API using FastAPI.

Run locally:
    uv run uvicorn main:app --host 0.0.0.0 --port 8000 --reload

The service exposes:
GET /hello?name=Alice -> {"message": "Hello Alice!"}
"""

from fastapi import FastAPI, Query
from pydantic import BaseModel

app = FastAPI(title="Say Hello API", version="0.1.0", description="Simple demo API returning greeting messages.")


class HelloResponse(BaseModel):
    message: str


@app.get("/hello", response_model=HelloResponse, summary="Return a hello greeting")
def hello(name: str = Query(..., min_length=1, max_length=100, description="Name to greet")) -> HelloResponse:  # noqa: D401
    """Return a hello greeting for the supplied name."""
    return HelloResponse(message=f"Hello {name}!")


def main():
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=False)


if __name__ == "__main__":  # pragma: no cover
    main()
