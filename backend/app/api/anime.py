# api/anime.py
# Router for anime-related endpoints

from fastapi import APIRouter, Query
from app.models import Anime
from app.services.jikan_client import BASE_URL
import requests

router = APIRouter()

@router.get("/anime")
def search_anime(name: str = Query(..., description="Anime name to search")):
    url = f"{BASE_URL}/anime?q={name}"
    response = requests.get(url)
    data = response.json()
    if data.get("data"):
        first = data["data"][0]
        type_value = first.get("type", "TV")
        anime = Anime(
            id=first["mal_id"],
            title=first["title"],
            synopsis=first.get("synopsis", ""),
            image_url=first.get("images", {}).get("jpg", {}).get("image_url", ""),
            score=first.get("score", 0.0),
            anime_type=type_value
        )
        popular = anime.isPopular()
        return {"anime": anime, "is_popular": popular}
    return {"error": "No anime found"}

@router.get("/anime/top")
def top_anime():
    url = f"{BASE_URL}/top/anime"
    response = requests.get(url)
    data = response.json()
    top_animes = []
    for item in data.get("data", [])[:10]:
        type_value = item.get("type", "TV")
        anime = Anime(id = item["mal_id"],
                      title = item["title"],
                      synopsis = item.get("synopsis", ""),
                      image_url = item.get("images", {}).get("jpg", {}).get("image_url", ""),
                      score = item.get("score", 0.0),
                      anime_type = type_value)
        top_animes.append(anime)
    return {"top_animes": top_animes}

