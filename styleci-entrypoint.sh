#!/usr/bin/env bash

isCommand() {
  # Retain backwards compatibility with common CI providers,
  # see: https://github.com/composer/docker/issues/107
  if [ "$1" = "sh" ]; then
    return 1
  fi

  styleci help "$1" > /dev/null 2>&1
}

# check if the first argument passed in looks like a flag
if [ "${1#-}" != "$1" ]; then
  set -- /usr/bin/tini -- styleci analyze "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'styleci' ]; then
  set -- /usr/bin/tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /usr/bin/tini -- styleci "$@"
fi

echo "$@"
exec "$@"
