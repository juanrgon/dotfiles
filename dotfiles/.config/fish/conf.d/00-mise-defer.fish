# Packaged mise auto-activates before config.fish, then its prompt hook drops
# PATH entries added there. config.fish activates it last instead.
set --global --export MISE_FISH_AUTO_ACTIVATE 0
