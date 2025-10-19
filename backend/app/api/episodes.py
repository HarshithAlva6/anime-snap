from app.services.jikan_client import BASE_URL
import requests
from app.models import Recommendation, Entry
from fastapi import APIRouter, FastAPI

router = APIRouter()

@router.get("/episodes")
def get_episodes():
    url = f"{BASE_URL}/watch/episodes"
    response = requests.get(url)
    data = response.json()
    episodes = []
    for data in data.get("data", [])[:10]:
        entry = data.get("entry", {})
        episode = data.get("episodes", [])
        for ep in episode:
            episodes.append(ep)
    return {"entry": entry, "episodes": episodes}

@router.get("/episodes/popular")
def get_popular_episodes():
    url = f"{BASE_URL}/watch/episodes/popular"
    response = requests.get(url)
    data = response.json()
    popular_episodes = []
    for data in data.get("data", [])[:10]:
        entry = data.get("entry", {})
        episode = data.get("episode", [])
        for ep in episode:
            popular_episodes.append(ep)
    return {"entry": entry, "popularEpisodes": popular_episodes}