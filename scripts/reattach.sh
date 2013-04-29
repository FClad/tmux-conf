#!/bin/bash

if [[ "$(uname)" = "Darwin" ]]; then
	reattach-to-user-namespace -l $@
else
	exec "$@"
fi

