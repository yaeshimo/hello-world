# utils
shellで使われるコマンドを自分用にメモ
基本的に調べて使ったコマンドを書いていく
詳しくはarchのwikiとか調べた方がいい


---
# 正規表現
**実装によって異なる場合があることに注意**
実装は異なっていても、基本的な考え方は同じなので
基本を押さえればおｋ

| 正規表現メタ文字 | 説明 |
| :---: | :--------- |
| `.` | 一文字マッチ |
| `*` | 直前の文字を0回以上繰り返す文字列にマッチ |
| `+` | 直前の文字を1回以上繰り返す文字列にマッチ |
| `?` | 直前の文字の0回または1回の出現にマッチ |
| `^` | 行頭を表現する位置指定 |
| `$` | 行末を表現する位置指定 |
| `\b` | 単語の境界に位置指定 |
| `\B` | \b以外にマッチ |
| `[]` |［］内の任意の一文字にマッチ |
| `[^]` | []内の任意の一文字以外にマッチ...否定not |
| `()` | 包括指定()内でマッチした文字列を保存...キャプチャorグループ化 |
| `(?:)` | (?:pattern)...キャプチャを抑止しグループ化 |
| `$1` | 1番目の包括指定で保存した文字列を参照 |
| `{n}` | 直前の文字のn回ちょうどの繰り返し |
| `{n,}` | 直前の文字のn回以上の繰り返し |
| `{n,m}` | 直前の文字のn回以上m回以下の繰り返し |
| `-` | 範囲指定-の左に指定した文字コードから右に指定した値まで |
| `\d` | 一個の半角数字[0-9] |
| `\D` | \d以外にマッチ |
| `\w` | 英単語を構成する文字[a-zA-Z0-9\_] |
| `\W` | \w以外にマッチ |
| `\s` | 空白文字、タブやスペース、リターンなど |
| `\S` | \s以外にマッチ |
| `\` | 直後のメタ文字のメタを解除 |

**ｍｄの表で区切りと解釈されるためこちらで説明**

` | `(パイプ)文字列or文字列
いずれかの文字列にマッチ

追記:
上記`|`はバーティカルバーというらしい...
また、mdの表に入れるには文字参照でおｋっぽい

**文字参照**
`&#`十進数指定
`&#x`十六進数指定

| &#124;(バーティカルバー) | 説明 |
| :----------------------: | :--- |
| (pattern1&#124;pattern2) | 前後いずれかにマッチ |
| (pattern1&#x7c;pattern2) | 前後いずれかにマッチ |

......一応表現出来たけど...
コード指定\` &#x7c; \`しようとすると文字参照が生で出てきてしまう

**正規表現vimの場合**
vimの正規表現はメタ文字をエスケープして指定するっぽい

|正規表現vim|説明perl系|
|:---------:|:---------|
| \(hoge\) | (hoge) |
| hoge\&#x7c;piyo | hoge&#x7c;piyo |
| hogeQ\? | hogeQ? |
| go\+doc | go+doc |
| go\{2,4}gle | go{2,4}gle |

|vim文字クラス（POSIX文字クラス）|説明perl系|
|:------------------------------:|:---------|
|[::]|\|
|[:digit:]|十進数|
|[:xdigit:]|十六進数|
|[:alpha:]|アルファベット|
|[:alnum:]|\w(アンダースコアも含めるかは未調査)|
|[:space:]|[]|
|[:blank:]|[\t]|
|[:graph:]|スペースを除いた印刷可能な文字|
|[:print:]|スペースを含めた印刷可能な文字|
|[:upper:]|アルファベット大文字|
|[:lower:]|アルファベット少文字|
|[:punct:]|句読点文字|
|[:cntrl:]|制御文字|
|[:return:]|CR...\n|
|[:tab:]|Tab...\t|
|[:escape:]|Esp|
|[:backspace:]|BS|


---
# ターミナルのショートカット
- `ctrl-a` 行の頭へ
- `ctrl-e` 行の末へ
- `ctrl-f` カーソルを1つ進める
- `ctrl-b` カーソルを1つ戻す
- `ctrl-u` カーソルから行頭に向けてキルバッファに入れる
- `ctrl-y` キルバッファからバッファの貼り付け
- `ctrl-l` 画面の再表示
- `ctrl-p` バッシュ履歴上へ
- `ctrl-n` バッシュ履歴下へ
- `ctrl-r` バッシュ履歴検索
- `ctrl-alt-backspace` xorgの強制終了

`[command] $`
シェルコマンドの終了を待たずにバックグランドジョブになる

`history`
コマンドの履歴を表示　![ヒストリー番号]　で実行

`man [:digit:] [command]`
コマンドのマニュアル

---
# commands
1. file
2. system
3. tool

TODO: 分類の仕方考える
使用例とよく使うオプションの追記


---
## 1.file
### リダイレクト
`>`
出力のリダイレクト（上書き）

`>>`
出力のリダイレクト（追記）

`<`
入力のリダイレクト

`<<`
ヒアドキュメント
終了文字が現れるまで標準入力へ送る(終端文字の指定)

`<(command)`
プロセス置換 コマンドの出力結果をファイルとして扱う

`|`
左のコマンドの出力結果を右のコマンドに引き渡す（パイプ）

`&1`
ファイルディスクリプタ1番 標準入力

`&2`
ファイルディスクリプタ2番 標準エラ-出力

`1>`
標準出力、ファイルディスクリプタ1番のリダイレクト

`2>`
標準エラ-出力、ファイルディスクリプタ2番のリダイレクト

### 検索や表示
`ls`
ファイルの一覧表示

`dir`
ファイルの表示

`df -h`
show disk cap

`du -h`
show dir size

`cat`
binaryを読むと表示が崩れる
$resetでterminalを再起動すると回復するかも

`more`
文字列を一画面ずつ表示

`less`
文字列をスクロールして確認できる

`locate`
あらかじめ作られたファイルのインデックスを検索する
インデックスの作成は`sudo updatedb`

`find`
ファイルを検索する
読み取り権限がない場所は探せない

`grep`
渡された文字列をフィルタして出力する
正規表現が使える

`pwd`
show current dir

`file /path/to/file`
fileの情報を調べる

`<commmands> | tee /dst/file`
渡された内容を標準出力とファイルに書き込む

`touch /path/to/file`
ファイル、ディレクトリのタイムスタンプ操作
fileが存在しなければ新たに作成される

### etc
`dd count=N bs=N if=/path of=/path`


---
## 2.system
### permission
`su`

`sudo`

`visudo`

`chmod [ugo][+-][rwx]`

`chown user:group /dif/or/file/`

`passwd user`

### user
`groups`

`adduser -m -G addgroup -s /default/shell name`

`groupadd groupname`

`groupdel groupname`

`chgrp group /dir/or/file`

`gpasswd --add user group`

`gpasswd -delete user group`

### パーティション操作
`fdisk -l`
show disk info

` fdisk /path/to/device `
interactive  
- m(menu? show help)
- n(new)
- p(primary partition)
- e(extended partition)
- specify size
  - +1000M
  - +1G
- a(add flag)
- t(partition type)
- d(delete)
- w(write)
- q(quit)

### マウント
`mount`
(例：mount/dev/hda2/mnt/d)←ドライブをファイル「d」にマウント

`umount`

### 設定されている環境変数を調べる
`printenv`

`env`

### プロセス
`ps`

`top`

`pgrep`

`pkill`

`kill`

`pstree`

### link
`ln`

`unlink`

`readlink`

### setting
`loadkeys jp106`
for tty terminal

`stty`
terminal line settings

### ネットワーク
`ps`

`ss`

`ip`

`ping`

`tcpdump`

`iptables`

### ssh
`ssh`

`ssh-keygen`

`ssh-agent`

`ssh-add`

`scp`


---
## 3.tool
### エディター
`vim`

`vi`

`emacs`

`nano`

### vm
`vboxmanage`
- `startvm "vm name" --type headless "vm name"`
- `list runningvms`
- `controlvm "vm name" poweroff`

`vboxheadless`
- `-startvm`

### etc
`feh`
