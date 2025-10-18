
from fastapi import APIRouter
from app.models import Recommendation, Entry
from app.services.jikan_client import BASE_URL
import requests

router = APIRouter()

def parse_entry(entry):
    return Entry(
        mal_id=entry["mal_id"],
        title=entry["title"],
        image_url=entry.get("images", {}).get("jpg", {}).get("image_url", ""),
        url=entry.get("url", "")
    )

def parse_recommendation(rec):
    entries = [parse_entry(e) for e in rec.get("entry", [])]
    user_info = rec.get("user", {})
    return Recommendation(
        entries=entries,
        content=rec.get("content", ""),
        user=user_info
    )

@router.get("/recommendations/anime")
def get_recommendations():
    url = f"{BASE_URL}/recommendations/anime"
    response = requests.get(url)
    data = response.json()
    recommendations = [parse_recommendation(rec) for rec in data.get("data", [])[:10]]
    return {"recommendations": recommendations}

@router.get("/recommendations/manga")
def get_manga_recommendations():
    url = f"{BASE_URL}/recommendations/manga"
    response = requests.get(url)
    data = response.json()
    recommendations = [parse_recommendation(rec) for rec in data.get("data", [])[:10]]
    return {"recommendations": recommendations}