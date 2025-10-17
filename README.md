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

ssh-keygen -t ed25519 -C "harshalva.titan@csu.fullerton.edu"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
Save it in GitHub → Settings → SSH and GPG keys → New SSH key
git remote set-url origin git@github.com:HarshithAlva6/anime-snap.git
git push

(ssh-add --apple-use-keychain ~/xcode)
(chmod 600 ~/xcode)
(sudo rm -r ~/xcode)


IOS
Add the key: App Transport Security Settings (this may auto-complete).

Expand this new setting.

Click the + button next to it and add the key: Allow Arbitrary Loads to YES.