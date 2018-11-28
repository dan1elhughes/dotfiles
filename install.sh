#!/usr/bin/env bash
#--------------------------------------------------------------------------
# Install
#--------------------------------------------------------------------------
#
# Installs all configuration.
#
#
DFD="$HOME/.dotfiles"

# Creates a sample .env file.
if [ -f "$DFD/.env" ]; then
	. "$DFD/.env"
else
	cp "$DFD/example.env" "$DFD/.env"
	echo "Created .env file. Update this with your own settings, then run 'dotfiles reload'."
fi

# Copies all link files to their dot-prefixed equivalent.
# I.e, config/link/bashrc => ~/.bashrc
for f in $DFD/config/link/*; do
	file="$HOME/.$(basename "$f")"
	rm "$file" 2> /dev/null
	cp "$f" "$file"
	echo ":: $file"
done

# Copies all Atom configuration.
mkdir -p "$HOME/.atom"
for f in $DFD/config/atom/*; do
	file="$HOME/.atom/$(basename "$f")"
	rm "$file" 2> /dev/null
	cp "$f" "$file"
	echo ":: $file"
done

# Creates ssh config
SSH_CONTENT=''
if [ -n "$SSH_CONFIG" ]; then
	for server in $SSH_CONFIG; do
		IFS=':' read host user hostname <<< "$server"

		SSH_CONTENT=$SSH_CONTENT"Host $host\n"
		SSH_CONTENT=$SSH_CONTENT"\tUser $user\n"
		SSH_CONTENT=$SSH_CONTENT"\tHostName $hostname\n\n"
	done
	mkdir -p "$HOME/.ssh"
	echo -e "$SSH_CONTENT" > "$HOME/.ssh/config"
	echo ":: $HOME/.ssh/config"
fi
