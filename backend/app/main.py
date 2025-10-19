from fastapi import FastAPI
from app.api import anime, recommendations, episodes

app = FastAPI()

# Include anime router
app.include_router(anime.router)
app.include_router(recommendations.router)
app.include_router(episodes.router)

# Root endpoint
@app.get("/")
def root():
    return {"message": "Welcome to Anime Snap backend!"}

