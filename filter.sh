#!/bin/bash

# Email Filter+Extractor

# text style

BOLD='\e[1m'

# Warna Teks

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAENTA='\033[0;35m'
LIGHTRED='\033[0;91m'
LIGHTGREEN='\033[0;92m'

LIGHTCYAN='\033[0;96m'

# background color

BACKGREEN='\033[0;42m'
BACKBLUE='\033[0;44m'

# no style

NC='\033[0m'


header(){

  printf " ${LIGHTRED}   _  __                __        _______        ${NC}\n"
  printf " ${LIGHTRED}  / |/ __ _____ ___ ___/ ___ ____/  _/ _ \  ${NC}\n"
  printf " ${LIGHTRED} /    / // / -_/ _ / _  / -_/ ___/ // // / ${NC}\n"
  printf " ${LIGHTRED}/_/|_/\_, /\__/_//_\_,_/\__/_/ /___/____/  ${NC}\n"
  printf " ${LIGHTRED}     /___/                                  ${NC}\n"
  
 
}


clear
header


echo ""
echo "Email Extractor Plus Filter"
echo ""

# end of bicit

echo "Daftar file di direktori ini : "
echo ""

ls

echo ""

# ---

echo ""
printf "[+] Mailist : ${LIGHTCYAN}"
read emaillist
printf "${NC}"
# ---

printf "[+] Hasil Akan Di Save Ke : ${LIGHTCYAN}"
read save
printf "${NC}"

# ---

printf "[+] Membuat Direktori : "

if [[ ! -d "$save" ]]; then
  mkdir $save
  echo -e "${GREEN}[OK]${NC}"
else
  echo -e "${RED}[ERR]${NC} | ${RED}File Sudah Ada${NC}"
fi

echo ""

# ---

counter=$(wc -l < $emaillist)
echo -e "${NC}[+] Total lines : [${LIGHTGREEN}$counter${NC}]"
echo "[+] Membersihkan daftar email Anda, menurunkan kata dalam daftar Anda, dan menghapus duplikat email, Harap tunggu ..."

# Code for cleaning email list
grep -Eiorh '([[:alnum:]_.-]+@[[:alnum:]_.-]+?\.[[:alpha:].]{2,6})' $emaillist | sort | uniq > temp_list && mv temp_list $emaillist
# Lowering the word
cat $emaillist | awk '{print tolower($0)}' | sort | uniq > temp_list && mv temp_list $emaillist
# Removing duplicates line
sort -u $emaillist | uniq > temp_list && mv temp_list $emaillist

counter=$(wc -l < $emaillist)

echo ""
echo "[+] Done ~"
echo ""
echo -e "[+] You have [${LIGHTGREEN}$counter${NC}] email"
echo ""

# Array list here

microsoft_family=( hotmail live outlook msn )
yahoo_family=( yahoo ymail btinternet bt rocketmail sky )
google_family=( gmail google googlemail )
aol_family=( aol )

# Array list here

otherpath="other_mail.txt"
cp $emaillist "$save/$otherpath"

# ---- GREPING MICROSOFT FAMILY ---- #

# ---

thispath="microsoft_family.txt"

# ---

echo "[+] Catch microsoft family : "
echo "[+] I have list : "
for (( i = 0; i < ${#microsoft_family[@]}; i++ )); do
  echo "      [-] @${microsoft_family[$i]}.*"
done
echo ""

# --- Looping ---- #

for (( i = 0; i < ${#microsoft_family[@]}; i++ )); do
  emailtogrep="@${microsoft_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done

# --- Looping ---- #

counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Microsoft Family"
echo ""

# ---- END OF GREPING HOTMAIL FAMILY ---- #

#############################

# ---- GREPING YAHOO FAMILY ---- #

# ---

thispath="yahoo_family.txt"

# ---

echo "[+] Catch yahoo family : "
echo "[+] I have list : "
for (( i = 0; i < ${#yahoo_family[@]}; i++ )); do
  echo "      [-] @${yahoo_family[$i]}.*"
done
echo ""

# --- Looping ---- #

for (( i = 0; i < ${#yahoo_family[@]}; i++ )); do
  emailtogrep="@${yahoo_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done

# --- Looping ---- #

counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Yahoo Family"
echo ""

# ---- END OF GREPING YAHOO FAMILY ---- #

#############################

# ---- GREPING GOOGLE FAMILY ---- #

# ---

thispath="google_family.txt"

# ---

echo "[+] Catch google family : "
echo "[+] I have list : "
for (( i = 0; i < ${#google_family[@]}; i++ )); do
  echo "      [-] @${google_family[$i]}.*"
done
echo ""

# --- Looping ---- #

for (( i = 0; i < ${#google_family[@]}; i++ )); do
  emailtogrep="@${google_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done

# --- Looping ---- #

counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Google Family"
echo ""

# ---- END OF GREPING GOOGLE FAMILY ---- #

# ---- GREPING AOL FAMILY ---- #

# ---

thispath="aol_family.txt"

# ---

echo "[+] Catch aol family : "
echo "[+] I have list : "
for (( i = 0; i < ${#aol_family[@]}; i++ )); do
  echo "      [-] @${aol_family[$i]}.*"
done
echo ""

# --- Looping ---- #

for (( i = 0; i < ${#aol_family[@]}; i++ )); do
  emailtogrep="@${aol_family[$i]}."
  printf "      [+] Catch $emailtogrep* : "
  cat $emaillist | grep "$emailtogrep" | sort | uniq >> "$save/$thispath"
  cat "$save/$otherpath" | grep -v "$emailtogrep" | sort | uniq > "$save/tmp_other" && mv "$save/tmp_other" "$save/$otherpath"
  counter=$(cat "$save/$thispath" | grep -c "$emailtogrep")
  if [[ $counter != 0 ]]; then
    printf "${GREEN}[OK]${NC} | ${BLUE}$counter${NC} catched\n"
  else
    printf "${RED}[NO]${NC} | There is no ${BLUE}${emailtogrep}*${NC} email\n"
  fi
done

# --- Looping ---- #

counter=$(wc -l < "$save/$thispath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Aol Family"
echo ""

# ---- END OF GREPING AOL FAMILY ---- #

#############################

# ---- OTHER MAIL ---- #

echo "[+] Other Mail"

counter=$(wc -l < "$save/$otherpath")
echo ""
echo -e "[+] Finally you have [${LIGHTGREEN}$counter${NC}] Other Mail"
echo ""
echo "[+] Done -"
echo ""

# ---- OTHER MAIL ----#
