#!/bin/bash

ACTIVE_WINDOW=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_NAME | cut -d '"' -f 2)

if [[ "${ACTIVE_WINDOW}" != "" ]]; then
  # cut the active window to 22 characters on the echo
  # add ... at end when active window is > 71
  if [[ ${#ACTIVE_WINDOW} -gt 72 ]]; then
    echo "${ACTIVE_WINDOW:0:72}..."
  else
    echo "${ACTIVE_WINDOW}"
  fi

  echo ""
fi
