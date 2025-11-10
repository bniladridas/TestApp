#!/bin/bash

# Rewrite commit message: lowercase first line, truncate at word boundary if needed, add "..." if truncated

read -r FIRST_LINE
REST=$(cat)

# Lowercase first line
FIRST_LINE=$(echo "$FIRST_LINE" | tr '[:upper:]' '[:lower:]')

# Check if longer than 40
if [ ${#FIRST_LINE} -gt 40 ]; then
  # Truncate at last space before 40
  TRUNCATED=$(echo "$FIRST_LINE" | cut -c1-40)
  LAST_SPACE=$(echo "$TRUNCATED" | awk '{print length($0) - length($NF)}')
  if [ $LAST_SPACE -gt 0 ]; then
    FIRST_LINE=$(echo "$FIRST_LINE" | cut -c1-$LAST_SPACE | sed 's/[[:space:]]*$//')
  else
    FIRST_LINE=$TRUNCATED
  fi
  FIRST_LINE="${FIRST_LINE}..."
fi

echo "$FIRST_LINE"
echo "$REST"