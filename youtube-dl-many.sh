#!/bin/sh

if [ "$#" -lt 1 ]
then
   echo "Expecting path to a textfile as parameter. Aborting."
   exit 1
fi

LISTFILE=$1

if [ ! -f "$LISTFILE" ]
then
   echo "File '$LISTFILE' not found. Aborting."
   exit 1
fi

cat "$LISTFILE" | while read URL
do
   echo "Downloading '$URL' ..."
   ./youtube-dl.sh "$URL"
   echo "Done."
   echo ""
done

exit 0
