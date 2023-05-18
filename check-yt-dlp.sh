#!/bin/bash

# check if sha256sum command exists

if ! [ -x "$(command -v sha256sum)" ]
then
	echo "sha256sum not in PATH - exiting" >&2
	exit 1
fi

# check if yt-dlp is installed
# store path of yt-dlp in variable

file=$(command -v yt-dlp)

if [[ -z $file ]]
then
	echo "yt-dlp not in PATH - exiting" >&2
	exit 1
fi

# get checksum from github

checksum=$(wget -qO- "https://github.com/yt-dlp/yt-dlp/releases/latest/download/SHA2-256SUMS" | egrep "yt-dlp$" | cut -d ' ' -f 1)

# check if string has been retrieved

if [[ -z $checksum ]]
then
	echo "unable to retrieve checksum from github - exiting" >&2
	exit 1
fi

# store sha256sum of local yt-dlp in variable

testsum=$(sha256sum $file | cut -d ' ' -f 1)

# output checksums to console

echo -ne "github: \x1b[0;1;34m$checksum\x1b[0m\n"

echo -ne "local:  \x1b[0;1;33m$testsum\x1b[0m\n"

# check if checksums are equal

if [[ "$checksum" != "$testsum" ]]
then
echo -ne "sha256 \x1b[0;1mnot equal\x1b[0m\nmaybe yt-dlp has been updated or the local file is corrupted\n"
exit 0
else
echo "sha256 OK"
fi

exit 0
