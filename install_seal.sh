#!/bin/bash

# Judul
echo "=============================================="
echo "          SEAL INSTALLATION SCRIPT            "
echo "               EVERLEX AIRDROP                "
echo "                                              "
echo "  Join Channel : https://t.me/EverlexAirdrop  "                                     
echo "=============================================="
echo ""
echo "Script ini akan melakukan:"
echo "1. Update sistem dan instalasi dependensi"
echo "2. Instal Node.js, PNPM, dan Screen"
echo "3. Clone repository SEAL dari GitHub"
echo "4. Instal dependensi frontend"
echo "5. Menjalankan aplikasi"
echo ""

# Pilihan untuk melanjutkan
read -p "Apakah Anda ingin melanjutkan instalasi? (y/n) " choice
case "$choice" in
  y|Y )
    echo "Memulai proses instalasi..."
    echo ""
    ;;
  n|N )
    echo "Instalasi dibatalkan."
    exit 0
    ;;
  * )
    echo "Pilihan tidak valid, instalasi dibatalkan."
    exit 1
    ;;
esac

# Update sistem dan instal dependensi
echo "[1/5] Mengupdate sistem dan menginstal dependensi..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y screen nodejs curl

# Instal PNPM
echo "[2/5] Menginstal PNPM..."
npm install -g pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.bashrc

# Clone repository
echo "[3/5] Mengclone repository SEAL..."
git clone https://github.com/MystenLabs/seal.git ~/seal

# Instal dependensi frontend
echo "[4/5] Menginstal dependensi frontend..."
cd ~/seal/examples/frontend
pnpm install

# Pilihan metode eksekusi
echo "[5/5] Menjalankan aplikasi..."
echo ""
echo "Pilih metode eksekusi:"
echo "1. Jalankan dengan screen (rekomendasi - aplikasi tetap berjalan setelah terminal ditutup)"
echo "2. Jalankan tanpa screen (aplikasi akan berhenti ketika terminal ditutup)"
echo "3. Tidak jalankan sekarang"
echo ""
read -p "Masukkan pilihan (1/2/3): " run_choice

case "$run_choice" in
  1 )
    echo ""
    echo "Aplikasi akan dijalankan dalam screen session bernama 'seal'"
    echo "Anda dapat melepaskan terminal dengan menekan Ctrl+A kemudian D"
    echo "Untuk kembali ke screen session, ketik: screen -r seal"
    echo ""
    echo "Akses aplikasi di: http://localhost:5173/"
    echo ""
    read -p "Tekan Enter untuk melanjutkan dan menjalankan aplikasi..."
    
    screen -S seal -dm bash -c 'cd ~/seal/examples/frontend && pnpm dev; exec bash'
    
    echo "Instalasi selesai!"
    echo "Untuk memeriksa aplikasi, jalankan: screen -r seal"
    echo "Untuk keluar dari screen session tanpa menghentikan aplikasi, tekan Ctrl+A kemudian D"
    ;;
  2 )
    echo ""
    echo "Aplikasi akan dijalankan di terminal ini..."
    echo "Akses aplikasi di: http://localhost:5173/"
    echo "Untuk menghentikan aplikasi, tekan Ctrl+C"
    echo ""
    read -p "Tekan Enter untuk melanjutkan dan menjalankan aplikasi..."
    
    cd ~/seal/examples/frontend && pnpm dev
    
    echo "Aplikasi telah dihentikan."
    ;;
  3 )
    echo ""
    echo "Instalasi selesai!"
    echo "Anda dapat menjalankan aplikasi nanti dengan perintah:"
    echo "  cd ~/seal/examples/frontend && pnpm dev"
    echo "Atau dengan screen:"
    echo "  screen -S seal -dm bash -c 'cd ~/seal/examples/frontend && pnpm dev; exec bash'"
    ;;
  * )
    echo "Pilihan tidak valid, aplikasi tidak dijalankan."
    echo "Anda dapat menjalankannya nanti secara manual."
    ;;
esac
