from fastapi import APIRouter
from app.models import Anime
from app.services.jikan_client import BASE_URL
import requests
from fastapi import Query

router = APIRouter()

@router.get("/recommendations/anime")
def get_recommendations():
    url = f"{BASE_URL}/recommendations/anime"
    response = requests.get(url)
    data = response.json()
    recommendations = []
    for rec in data.get("data", [])[:10]:
        entries = []
        for entry in rec.get("entry", []):
            anime_entry = {
                "mal_id": entry["mal_id"],
                "title": entry["title"],
                "image_url": entry.get("images", {}).get("jpg", {}).get("image_url", ""),
                "url": entry.get("url", "")
            }
            entries.append(anime_entry)
        recommendation = {
            "entries": entries,
            "content": rec.get("content", ""),
            "user": rec.get("user", "")
        }
        recommendations.append(recommendation)
    return {"recommendations": recommendations}