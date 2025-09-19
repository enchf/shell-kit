mkcd() { mkdir -p "$1" && cd "$1"; }

prune-git() {
  git fetch --prune
  git branch -vv | grep ': gone]' | awk '{print $1}'
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
}
