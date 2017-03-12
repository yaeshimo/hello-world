#!/bin/bash
set -eu

# FROM: http://d.hatena.ne.jp/ozuma/20130928/1380380390

# ${VAR[#%/]PATTERN}
# escape=\
# p=pattern

echo "HOME=$HOME"
echo "----------------------------------------"

p="*/"
echo ${HOME#${p}} # 前方一致 マッチ部削除 最短マッチ
echo ${HOME##${p}} # 前方一致 マッチ部削除 最長マッチ
echo "----------------------------------------"
p="/*"
echo ${HOME%${p}} # 後方一致 マッチ部削除 最短マッチ
echo ${HOME%%${p}} # 後方一致 マッチ部削除 最長マッチ
echo "----------------------------------------"
# on bash
echo ${HOME/\//!} # 文字列置換 はじめの一致のみ置換
echo ${HOME//\//!} # 文字列置換 すべての一致を置換


# EOF
