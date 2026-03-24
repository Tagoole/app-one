from fastapi import FastAPI





app = FastAPI()


@app.get("/health")
async def health():
    return {"message": " 1.. App One is healthy and ready to go"}







