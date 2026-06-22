#!/usr/bin/env bash
input=$(cat)

parsed=$(printf '%s' "$input" | node -e "
let data = '';
process.stdin.on('data', d => data += d);
process.stdin.on('end', () => {
  try {
    const parsed = JSON.parse(data);
    const model = (parsed.model && parsed.model.display_name) || 'Unknown Model';
    const used = (parsed.context_window && parsed.context_window.used_percentage != null)
      ? parsed.context_window.used_percentage
      : '';
    console.log(model + '\n' + used);
  } catch(e) { console.log('Unknown Model\n'); }
});
")

model=$(echo "$parsed" | head -1)
used=$(echo "$parsed" | sed -n '2p')

if [ -n "$used" ]; then
  filled=$(echo "$used" | awk '{printf "%d", int($1 / 5 + 0.5)}')
  bar=""
  for i in $(seq 1 20); do
    if [ "$i" -le "$filled" ]; then
      bar="${bar}█"
    else
      bar="${bar}░"
    fi
  done
  pct=$(printf "%.0f" "$used")
  printf "\033[0;36m%s\033[0m  [%s] %s%%" "$model" "$bar" "$pct"
else
  printf "\033[0;36m%s\033[0m  [░░░░░░░░░░░░░░░░░░░░] --%%" "$model"
fi
