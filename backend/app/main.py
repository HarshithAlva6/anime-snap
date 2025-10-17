from fastapi import FastAPI
from app.api import anime
from app.api import recommendations

app = FastAPI()

# Include anime router
app.include_router(anime.router)
app.include_router(recommendations.router)

# Root endpoint
@app.get("/")
def root():
    return {"message": "Welcome to Anime Snap backend!"}

