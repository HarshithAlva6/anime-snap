# anime-snap

python -m venv .venv
rm -rf venv (already existed from VScode)
source .venv/bin/activate

touch requirements.txt
python3 -m pip install --upgrade pip
pip install -r requirements.txt
mkdir app
uvicorn app.main:app --reload

/search?name=One%20Piece
