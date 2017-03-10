# utils
toolメモ  
基本的に調べて使ったコマンドのNOTE  
必要に応じて使ってないflagなんかはmanとarchwikiとnet  

TODO: reconsider classify

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

**mdの表で区切りと解釈されるためこちらで説明**

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
- `ctrl-w` wordをキルバッファに入れる
- `ctrl-y` キルバッファからバッファの貼り付け
- `ctrl-l` 画面の再表示
- `ctrl-p` バッシュ履歴上へ
- `ctrl-n` バッシュ履歴下へ
- `ctrl-r` バッシュ履歴検索 like it
- `ctrl-alt-backspace` xorgの強制終了

`[command] &` シェルコマンドの終了を待たずにバックグランドジョブになる
- `echo "hi" & & echo "foo"`
 - error
- `unset var ; echo "hi" & $var & echo "foo"`
 - non error

`history` コマンドの履歴を表示　![ヒストリー番号]　で実行

`man [:digit:] [dst]`

`reset` reboot terminal

---
# commands
1. file
2. system
3. tool

---
## 1.file
### リダイレクト
- `>` 出力のリダイレクト 上書き
- `>>` 出力のリダイレクト 追記
- `<` 入力のリダイレクト
- `<<` 終了文が現れるまで標準入力へ送る(<<[終了文の指定]) ヒアドキュメント
- `<(command)` プロセス置換 コマンドの出力結果をファイルとして扱う
- `|` 左のコマンドの出力結果を右のコマンドに引き渡す パイプ
- `&1` ファイルディスクリプタ1番 標準入力
- `&2` ファイルディスクリプタ2番 標準エラ-出力
- `1>` 標準出力 ファイルディスクリプタ1番のリダイレクト
- `2>` 標準エラ-出力 ファイルディスクリプタ2番のリダイレクト

### 検索や表示、作成
- `ls`
- `dir`
- `pwd` show current dir
- `file`

- `df` show disk cap
 - `df -h`
- `du` show dir size
 - `du -h`

- `cat` binaryを読むと表示が崩れる
 - `reset`でterminalを再起動すると回復するかも
- `more`
- `less`

- `locate` インデックスの作成は`sudo updatedb`
- `find`

- `grep`
- `tee` 渡された内容を標準出力とファイルに書き込む
 - `<commmands> | tee /dst/file`
- `touch` タイムスタンプ操作、fileが存在しなければ新たに作成される

- `head`
 - `command | head`
- `tail`
 - `command | tail`

- `mkfifo` make named pipe (fifo: First In First Out)
 - `mkfifo [pipe name]`
 - `cat [pipe name]`
 - `echo "hi" > [pipe name]`

- `gzip`
 - `gzip [file]`
 - `gzip -r [/path/to/dir/]`
 - `gzip -l [file.gz]` file info
 - `gzip -d [file.gz]` decompress: same gunzip
 - `gzip -dc [file.gz]` c: write on stdout
 - `gzip -[number of ratio] [file]` ratio=1..9 or best or fast

- `gunzip`

- `tar`
 - `x` extract
 - `c` create
 - `a` create archive auto compress
 - `z` create archive gzip [.gz]
 - `f` specify file or archive
 - `v` verbose
 - `tar xvf [archive.tar]`
 - `tar cvaf [outname.tar.gz] [target]`

### etc
TODO: classify  
`mkdir`
`rmdir`
`rm`
`mv`
`cp`
`dd`
- `dd count=N bs=N if=/path of=/path`


---
## 2.system
- `dmesg`
- `lsmod`
- `modprobe`
 - `-r`
- `insmod`
- `rmmod`

### systemd
`systemctl`
- `--help`
- `--user`
- `status`
- `[start:stop:enable:disable]`
- `is-[active:enabled:...etc]`
- `[reboot:poweroff]`
- `daemon-reload`
- `list-unit-files`
- `list-timers`

### journal
`journalctl`
- `-f` follow
- `--user-unit=dst.[service:...]`
- `-p [priority:number or label]`

### process
- `ps`
- `pstree`
- `top`
- `pgrep`
- `pkill`
- `kill`
 - `kill [pid]`
- `killall`
 - `killall [proc name]`

### systemd-nspawn
TODO: add

### localectl
`localectl`
- `set-keymap jp106`
- `set-locale [LANG:LANGUAGE:...] [locale]`
- `set-x11-keymap jp`

### setting
`loadkeys jp106`
for tty terminal

`stty`
terminal line settings

### permission
- `su -` to root
- `sudo`
- `visudo`
- `chmod`
 - `chmod [ugo][+-][rwx]`
- `chown`
 - `chown user:group /dif/or/file/`
- `passwd`
 - `passwd [username]`
 - `-l [user name]`
 - `-u [user name]`

### user
- `id`
- `groups`
- `adduser`
 - `-m -G addgroup -s /default/shell name`
- `groupadd [name]`
- `groupdel [name]`
- `chgrp`
 - `[group] /dir/or/file`
- `gpasswd`
 - `--add [user] [group]`
 - `--delete [user] [group]`

### パーティション操作
`fdisk -l` show disk info

`fdisk /path/to/device` to interactive
```sh:interactive
m(menu? show help)
n(new)
p(primary partition)
e(extended partition)
specify size
  +1000M
  +1G
a(add flag)
t(partition type)
d(delete)
w(write)
q(quit)
```

### マウント
`mount`
(例：mount/dev/hda2/mnt/d)←ドライブをファイル「d」にマウント

`umount`

### 設定されている環境変数を調べる
- `printenv`
- `env`


### link
`ln`
- `ln -s /path/substance /path/linkname`

`unlink`

`readlink`
- `readlink /path/link`
- `readlink -f /path/file/or/link`

`which`
- `which "command name"`

### ネットワーク
- `ss`
- `ip`
- `ping`
- `tcpdump`
- `iptables`
- `curl`
 - `curl -o /out/file URL`

### ssh
`ssh`
- `ssh -p [port] -i /path/to/key user@host`
- `ssh [alias]` pre set .ssh/config

`ssh-keygen`
- `ssh-keygen -t rsa -b 4096 -C "comment"`
- `ssh-keygen -t ecdsa -b 521 -f ~/.ssh/keyname -C "comment"`

`ssh-agent`
- `eval "$(ssh-agent)"`

`ssh-add`
- `ssh-add -l`
- `ssh-add /path/to/privatekey`

`scp`
- `scp /path/to/dst user@host:`
- `-P [port]`


---
## 3.tool
### env
`awk`

### editor
- `nano`
- `vi`
- `vim`
- `emacs`

### vm
`vboxmanage`
- `startvm "vm name" --type headless "vm name"`
- `list runningvms`
- `controlvm "vm name" poweroff`

`vboxheadless`
- `-startvm`

### docker
`docker`
- `info
- `run`
 - `run (image) arg`
- `images`
- `build`
 - `build -t (image tag) /path/to/dockerfile/dir/`
- `tag`
 - `tag (ID) rep/image-name:label`
- `rmi`
 - `rmi rep/image:tag`
 - `rmi $(docker images | awk '/^<none>/ { print $3 }')
- `login`
 - `login --username=user --email=at@mail`
- `push`
 - `push user/image:tag`
- `pull`
 - `pull user/image:tag`

### xorg
`xinit`

`xrandr`

`xset`
- `xset s [off:on}` screen saver
- `xset [+-]dpms` dpms is Display Power Management Signaling
- `xset q` query current info

### etc
TODO: classify
- `git`
- `feh`
- `seq`
 - `[from] [dst]`
- `shuf`
- `xclip`
- `sed`
 - `sed -e 's/word/dst/g'`
- `mkinitcpio`
 - `-p [dst pre set]`
