if [ "$#" -lt 1 ]
then
	URL="http://www.wearehappyfrom.com/"
else
	URL=$1
fi

TEMPFILE="source.html"
URLTMPFILE="urls.tmp"
URLFILE="urls.txt"

WGET=$(which wget)
YTDL="/Users/mario/Scripts/youtube-dl.sh"
YTDLMANY="/Users/mario/Scripts/youtube-dl-many.sh"

CMD="$WGET --user-agent=\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_5) AppleWebKit/537.74.9 (KHTML, like Gecko) Version/6.1.2 Safari/537.74.9\" -O \"$TEMPFILE\" \"$URL\""
echo "Executing command '$CMD'"

eval "$CMD"
echo ""

PATTERNS="(youtube\.com\/watch\?v=[a-zA-Z0-9_\-]+) (youtu\.be\/[a-zA-Z0-9_\-]+)"

#echo "Pattern: $PATTERNS"

for PATTERN in $PATTERNS
do
	CMD="grep --only-matching --extended-regexp \"$PATTERN\" \"$TEMPFILE\" >> \"$URLTMPFILE\""
	echo "Executing command '$CMD'"
	
	eval "$CMD"
	echo ""

	LINESNEW=$(wc -l "$URLTMPFILE" | awk '{print $1}')
	LINES=$((LINESNEW-LINESPREV))
	echo "A total of $LINES links found for pattern"
	LINESPREV=$LINESNEW

	echo ""
done

CMD="cat \"$URLTMPFILE\" | sort | uniq > \"$URLFILE\""
echo "Executing command '$CMD'"

eval "$CMD"
echo ""

LINESNEW=$(wc -l "$URLFILE" | awk '{print $1}')
echo "Downloading a total of $LINESNEW assets"
echo ""

CMD="$YTDLMANY \"$URLFILE\""
echo "Executing command '$CMD'"

eval "$CMD"
echo ""

echo "Done."
echo ""