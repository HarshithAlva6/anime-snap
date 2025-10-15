from fastapi import FastAPI
from app.api import anime

app = FastAPI()

# Include anime router
app.include_router(anime.router)

# Root endpoint
@app.get("/")
def root():
    return {"message": "Welcome to Anime Snap backend!"}

