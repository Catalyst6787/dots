# Simple Helix → WakaTime bridge

file="$1"
project=$(basename "$(git -C "$(dirname "$file")" rev-parse --show-toplevel 2>/dev/null || dirname "$file")")

wakatime-cli \
  --entity "$file" \
  --entity-type file \
  --project "$project" \
  --plugin "helix/$(helix --version 2>/dev/null || echo unknown)" \
  --write \
  --verbose >> ~/.wakatime-helix.log 2>&1

