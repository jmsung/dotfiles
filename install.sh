#!/usr/bin/env bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ${homedir}/dotfiles
# And also installs Homebrew Packages
# And sets Sublime preferences
############################

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

homedir=$1

# dotfiles directory
dotfiledir=${homedir}/dotfiles

# list of files/folders to symlink in ${homedir}
files="bash_profile bashrc bash_prompt bash_server_prompt bash_aliases private"

# change to the dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd ${dotfiledir}
echo "...done"

# create symlinks (will overwrite old dotfiles); skip files not present in the repo
# (e.g. .private is gitignored, so a fresh clone won't have it — don't make a broken link)
for file in ${files}; do
    if [ ! -e "${dotfiledir}/.${file}" ]; then
        echo "Skipping .$file (not present in dotfiles)."
        continue
    fi
    echo "Creating symlink to .$file in home directory."
    ln -sf "${dotfiledir}/.${file}" "${homedir}/.${file}"
done

# Download Git Auto-Completion
curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > ${homedir}/.git-completion.bash

# Run the Homebrew Script
./brew.sh
