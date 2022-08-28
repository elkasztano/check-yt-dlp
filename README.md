# check-yt-dlp
little bash script that checks file integrity of local yt-dlp installation
## usage / description
Nothing too fancy. Just run the script and it will write to screen if the checksums are equal or not.  
yt-dlp checksum is retrieved from https://github.com/yt-dlp/yt-dlp/releases/latest/download/SHA2-256SUMS and compared to the sha256 checksum of your local yt-dlp installation
