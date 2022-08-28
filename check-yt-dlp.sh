#!/bin/bash

# check if sha256sum command exists

if ! [ -x "$(command -v sha256sum)" ]
then
	echo "command sha256sum not found"
	exit 1
fi

# check if yt-dlp is installed
# store path of yt-dlp in variable

file=$(command -v yt-dlp)

if [[ -z $file ]]
then
	echo -ne "yt-dlp not found. Maybe not in \$PATH ?\n"
	exit 1
fi

# get checksum from github

checksum=$(wget -qO- "https://github.com/yt-dlp/yt-dlp/releases/latest/download/SHA2-256SUMS" | egrep "yt-dlp$" | cut -d ' ' -f 1)

# check if string has been retrieved

if [[ -z $checksum ]]
then
	echo "String is empty."
	exit 1
fi

# store sha256sum of local yt-dlp in variable

testsum=$(sha256sum $file | cut -d ' ' -f 1)

# output checksums to console

echo "github: $(tput setaf 4)$checksum$(tput sgr 0)"

echo -e "local:  $(tput setaf 5)$testsum$(tput sgr 0)\n"

# check if checksums are equal

if [[ "$checksum" != "$testsum" ]]
then
echo -ne "sha256 not equal\nmaybe yt-dlp has been updated or the local file is corrupted"
exit 0
else
echo "sha256 OK"
fi

exit 0
