#!/bin/bash

FILE_NAME=".au_alias_one"
DESTINATION="$HOME"
DEST_FILE="$HOME/.bashrc"

if [ ! -f "$FILE_NAME" ]; then
    echo "[au_alias] error: $FILE_NAME not found"
    return
fi

cp -v "$FILE_NAME" "$DESTINATION"

if ! grep -q "source ~/$FILE_NAME" $DEST_FILE; then
    echo "" >> $DEST_FILE
    echo "" >> $DEST_FILE
    echo "if [ -f ~/$FILE_NAME ]; then" >> $DEST_FILE
    echo "    source ~/$FILE_NAME" >> $DEST_FILE
    echo "fi" >> $DEST_FILE

    echo "[au_alias] added to $DEST_FILE"
else
    echo "[au_alias] already added to $DEST_FILE"
fi

source ~/.bashrc
