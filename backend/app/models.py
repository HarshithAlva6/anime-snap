# models.py
# OOP classes and Pydantic schemas for Anime Snap

from pydantic import BaseModel, Field

class Anime(BaseModel):
    id: int
    title: str
    synopsis: str = ""
    image_url: str = ""
    score: float = 0.0
    anime_type: str = Field("TV", alias="type")
    def __str__(self):
        return f"Anime(id={self.id}, title={self.title}, score={self.score})"
    def isPopular(self):
        threshold = 8.0 if self.anime_type == "TV" else 7.5
        return self.score > threshold

class Movie(Anime):
    duration: int = 0  
    director: str = ""
    def __str__(self):
        return f"Movie(id={self.id}, title={self.title}, director={self.director}, duration={self.duration} mins, score={self.score})"

class Entry(BaseModel):
    mal_id: int
    title: str
    image_url: str
    url: str

class Recommendation(BaseModel):
    entries: list[Entry]
    content: str
    user: dict

class Episode(BaseModel):
    mal_id: int
    title: str
    premium: bool
    url: str

class WatchEpisodes(BaseModel):
    entries: list[Entry]
    episodes: list[Episode]