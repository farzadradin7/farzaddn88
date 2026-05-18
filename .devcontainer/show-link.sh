#!/bin/bash

CONFIG="/etc/config.json"

UUID=$(jq -r '.inbounds[0].settings.clients[0].id' "$CONFIG")

if [ -z "$UUID" ] || [ "$UUID" = "null" ]; then
  echo "[g2ray] UUID not found."
  exit 1
fi

SNI="${CODESPACE_NAME}-443.app.github.dev"

# دریافت زمان تهران با فرمت 2026.5.18/22:47
TIMESTAMP=$(TZ=Asia/Tehran date +"%Y.%-m.%-d/%H:%M")

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
 
🌠 Your Config (Created: $TIMESTAMP Tehran Time) :

vless://${UUID}@94.130.33.41:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate1 ($TIMESTAMP)

vless://${UUID}@144.76.1.88:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate2 ($TIMESTAMP)

vless://${UUID}@142.54.178.211:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate3 ($TIMESTAMP)

vless://${UUID}@138.201.54.122:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate4 ($TIMESTAMP)

vless://${UUID}@144.76.1.88:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate5 ($TIMESTAMP)

vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate6 ($TIMESTAMP)

vless://${UUID}@204.12.196.34:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate7 ($TIMESTAMP)

vless://${UUID}@65.109.34.234:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate8 ($TIMESTAMP)

vless://${UUID}@94.130.13.19:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#Pain_Ultimate9 ($TIMESTAMP)

vless://${UUID}@94.130.13.19:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#ِPain_Ultimate10 ($TIMESTAMP)


@ThoseWhoAreNoLongerAmongUs"

echo ""
echo "================================================"
echo "  $LINK"
echo "================================================"
echo ""

# همیشه در یک فایل ثابت ذخیره کن (قدیمی رو بازنویسی می‌کنه)
OUTPUT_FILE="sub.txt"
echo "$LINK" > "$OUTPUT_FILE"
echo "[g2ray] Config saved to: $OUTPUT_FILE"

# اضافه کردن فایل به Git
git add "$OUTPUT_FILE" 2>/dev/null

# commit کردن تغییرات
git commit -m "Add new config - $NAME - $TIMESTAMP" 2>/dev/null

# push به مخزن GitHub
git push origin main 2>/dev/null || git push origin master 2>/dev/null

# SEND TO TELEGRAM
BOT_TOKEN="7843429722:AAGdb4texe8cErPbQycGsGzK2_4vpZiM0SI"
CHAT_ID="6920695217"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  --data-urlencode text="$LINK" > /dev/null 2>&1

echo "[g2ray] Also sent to Telegram"
