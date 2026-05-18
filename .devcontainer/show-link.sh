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

vless://${UUID}@94.130.33.41:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#1 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@144.76.1.88:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#2 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@142.54.178.211:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#3 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@138.201.54.122:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#4 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@144.76.1.88:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#5 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#6 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@204.12.196.34:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#7 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@65.109.34.234:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#8 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@94.130.13.19:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#9 ($TIMESTAMP) 4 Hours Active !

vless://${UUID}@94.130.13.19:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${SNI}&path=%2F#ِ10 ($TIMESTAMP) 4 Hours Active !


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
