# utils
toolメモ  
基本的に調べて使ったコマンドのNOTE  
REF: man archwiki google duckduckgo  

TODO: reconsider classify

## 正規表現
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

|正規表現vim|説明|
|:---------:|:---------|
| \(hoge\) | (hoge) |
| hoge\&#x7c;piyo | hoge&#x7c;piyo |
| hogeQ\? | hogeQ? |
| go\+doc | go+doc |
| go\{2,4}gle | go{2,4}gle |

|vim文字クラス（POSIX文字クラス）|説明|
|:------------------------------:|:---------|
|[:digit:]|十進数|
|[:xdigit:]|十六進数|
|[:alpha:]|アルファベット|
|[:alnum:]|\w(アンダースコアも含めるかは未調査)|
|[:space:]|SPACE TAB FF(改ペ-ジ)|
|[:blank:]|SPACE TAB|
|[:graph:]|スペースを除いた印刷可能な文字|
|[:print:]|スペースを含めた印刷可能な文字|
|[:upper:]|アルファベット大文字|
|[:lower:]|アルファベット少文字|
|[:punct:]|句読点文字|
|[:cntrl:]|制御文字|
|[:return:]|CR|
|[:tab:]|TAB|
|[:escape:]|ESP|
|[:backspace:]|BS|


## terminal
- `ctrl-a` 行の頭へ
- `ctrl-e` 行の末へ
- `ctrl-f` カーソルを1つ進める
- `ctrl-b` カーソルを1つ戻す
- `ctrl-u` カーソルから行頭に向けてキルバッファに入れる
- `ctrl-w` wordをキルバッファに入れる
- `ctrl-y` キルバッファからバッファの貼り付け
- `ctrl-l` 画面の再表示
- `ctrl-p` command履歴 上へ
- `ctrl-n` command履歴 下へ
- `ctrl-r` 履歴検索 like it
- `ctrl-alt-backspace` xorgの強制終了

- `[command] &` シェルコマンドの終了を待たずにバックグランドジョブになる
  - `echo "hi" & & echo "foo"` error
  - `unset var ; echo "hi" & $var & echo "foo"` non error
- `fg [job_id]` to foreground
- `jobs` show background jobs
- `[(command)]` subshell
- `history` コマンドの履歴を表示　![ヒストリー番号]　で実行
  - `![number]`
- `man [:digit:] [dst command]`
- `reset` reboot terminal

## commands
1. file
2. system
3. tool

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

- `: > file` truncate <file> --size 0

### 検索や表示、作成
- `ls`
- `dir`
- `dirs` show directories
- `pwd` show current dir
- `file`

- `df` show disk cap
  - `df -h`
- `du` show dir size
  - `du -h`

- `cat` binaryを読むと表示が崩れる
  - `reset`でterminalを再起動すると回復するかも
- `more`
- `less [file]`
  - ` less -N [file]` add line number

- `locate` インデックスの作成は`sudo updatedb`
- `find`
  - `find . -name "pattern"`
- `grep`
  - `grep -A 2 -n -e "pattern"` show pattern after 2 lines
  - `grep -C 2 -n -e "pattern"` show pattern 2 lines before and after
  - `grep -v -e "pattern" "file"` invert match
- `tee` 渡された内容を標準出力とファイルに書き込む
  - `<commmands> | tee /dst/file`
- `touch` タイムスタンプ操作、fileが存在しなければ新たに作成される

- `head`
  - `head /path/to/file`
  - `head -n 1 /path/to/file` -n lines
  - `command | head`
- `tail`
  - `tail -f /path/to/file` follow
  - `tail -n +2 file.txt`
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
  - `tar xvf [targetarchive.tar]` extract archive
  - `tar cvaf [outname.tar.gz] [targetdir]` create archive
  - `tar --help`
  - **Flags:**
    - `x` extract
    - `c` create
    - `a` create archive auto compress from filename
    - `z` create archive gzip [.gz]
    - `f` specify file or archive
    - `v` verbose

### etc
TODO: classif
- `mkdir`
- `rmdir`
- `rm`
- `mv`
- `cp`
- `dd`
  - `dd count=N bs=N if=/path of=/path`
- `lspci`
- `wc` print line, word, byte count
  - `wc -l /path/file` cout lines
- `xargs` generate command line
  - **Example**
    - `ls *.go | xargs head`
    - `git ls-files | xargs wc -l`
  - **Be careful**
    - `rm, mv, dd, ...etc.`


## 2.system
- `dmesg`
- `lsmod`
- `modprobe`
  - `-r`
- `insmod`
- `rmmod`
- `wait`
  - `sleep 5 && echo "wait for me"; wait $!`
- `mknod` req root
  - `mknod -m 0666 /chroot/dev/null c 1 3`
  - `mknod -m 0666 /chroot/dev/random c 1 8`
  - `mknod -m 0444 /chroot/dev/urandom c 1 9`
  - `mknod -m 0666 /chroot/dev/tty c 5 0`
  - `mknod -m 0666 /chroot/dev/ptmx c 5 2`
  - `mknod -m 0666 /chroot/dev/zero c 1 5`

### systemd
- `systemctl`
  - `--help`
  - `--user`
  - `status`
  - `[start:stop:enable:disable]`
  - `is-[active:enabled:...etc]`
  - `[reboot:poweroff]`
  - `daemon-reload`
  - `list-unit-files`
  - `list-timers`
- `sysctl` for kernel parameter
  - `sysctl -a` list kernel parameter
- `systemd-cgtop` top of cgroups
- `systemd-analyze`
  - `systemd-analyze --user set-log-level [loglevel]` loglevel: info, notice, ...

### journal
- `journalctl`
  - `-f` follow
  - `--user-unit=dst.[service:...]`
  - `-p [priority:number or label]`

- `logger` output to syslog
  - `logger 'hello'` pre `journalctl -f`

### process
- `ps`
  - `ps auxf`
- `pstree`
- `top`
- `pgrep`
- `pkill`
- `kill`
  - `kill [pid]`
- `killall`
  - `killall [proc name]`

### systemd-nspawn
- `systemd-nspawn` require root
  - **make container**
    - `sudo mkdir /path/to/container` remember need to root
    - `pacstrap -c -d .../container base --ignore linux`
  - `systemd-nspawn -b -D .../container` -b boot -D directory
  - `systemd-nspawn -b -n -D .../container` -n create virtual Ethernet link
- `machinectl`

### localectl
- `localectl`
  - `localectl set-keymap jp106`
  - `localectl set-locale [LANG:LANGUAGE:...] [locale]`
  - `localectl set-x11-keymap jp`
- `locale`
  - `locale -a`

### setting
- `loadkeys jp106` for tty terminal
- `stty` terminal line settings

### permission
- `su -` to root
- `sudo`
  - `sudo --list` list allowed commands
  - `sudo -K` remove timestamp
- `chmod`
  - `chmod [ugo][+-][rwx]`
- `chown`
  - `chown user:group /dif/or/file/`
- `passwd`
  - `passwd [username]`
  - `passwd -l [user name]` lock password
  - `passwd -u [user name]` unlock password
  - `passwd -d [user name]` delete password
- `pwck`
  - `pwck -s` sort /etc/passwd
- `visudo` edit /etc/sudoers
- `vipw` edit /etc/passwd
- `vigr` edit /etc/group

### user
- `id`
- `users` show current user
  - `cat /etc/passwd` show all users
- `useradd`
  - `useradd -m -G [specify add group] -s /default/shell [user name]`
  - `useradd -M [specify home] -G [specify add group] -s /default/shell [user name]`
- `usermod` modify user
  - `usermod -s /path/to/shell`
  - `usermod -l [new name] [old name]` change login name
  - `usermod -d /new/home/ -m [user name]` make new home directory from [user name]
- `userdel`
  - `userdel -r [user name]`
- `groups`
  - `groups [user]` show user groups
  - `cat /etc/group` show system groups
- `groupadd [name]`
- `groupdel [name]`
- `chgrp`
  - `chgrp [group] /dir/or/file`
- `gpasswd`
  - `gpasswd --add [user] [group]`
  - `gpasswd --delete [user] [group]`
- `groupmod`
  - `groupmod -n [new name] [old name]`

### パーティション操作
- `fdisk -l` show disk info

- `fdisk /path/to/device` to interactive
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

- `lsblk`
  - `lsblk --fs`

### マウント
- `mount`
  - `mount /dev/sdaN /mnt`
- `umount`

### 設定されている環境変数を調べる
- `printenv`
- `env`


### link
- `ln`
  - `ln -s /path/substance /path/linkname`
- `unlink` be careful if specify regular file then is remove it
- `readlink`
  - `readlink /path/link`
  - `readlink -f /path/file/or/link`
- `which`
  - `which "command name"`

### ネットワーク
- `ss`
- `ip`
- `ping`
- `tcpdump`
  - `tcpdump port [number]`
- `iptables`
  - `iptables -nvL --line-numbers`
  - `iptables -N CHAINNAME` -n new
  - `iptables -P [FORWARD:OUTPUT:INPUT] [DROP:ACCEPT]` -p policy
  - `iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT`
    - `-m` match
    - **--ctstate** `NEW, ESTABLISHED, RELATED, INVALID`
  - `iptables -A TCP -p tcp --dport 22 -j ACCEPT` -A append
  - `iptables -A TCP -p tcp --dport 80 -j ACCEPT`
  - `iptables -A TCP -p tcp --dport 443 -j ACCEPT`
  - `iptables -A UDP -p udp --dport 53 -j ACCEPT` DNS server
  - `iptables -t nat -A PREROUTING -p tcp -m tcp --dport [catch] -j REDIRECT --to-ports [throw]`
- `iptables-save`
- `nft` nftables
  - `nft list ruleset`
- `curl`
  - `curl -o /out/file URL`

### ssh
- `ssh`
  - `ssh -p [port] -i /path/to/key user@host`
  - `ssh [alias]` preset into .ssh/config

- `ssh-keygen`
  - `ssh-keygen -t rsa -b 4096 -C "comment"`
  - `ssh-keygen -t ecdsa -b 521 -f ~/.ssh/private -C "comment"` not -b 512
  - `ssh-keygen -t ed25519 -f ~/.ssh/private-id_ed25519 -C "comment"`
  - `ssh-keygen -p -f ~/.ssh/private` modify passphrase
  - `ssh-keygen -c -f ~/.ssh/private` modify comment

- `ssh-agent`
  - `eval "$(ssh-agent)"`

- `ssh-add`
  - `ssh-add -l`
  - `ssh-add /path/to/privatekey`

- `scp`
  - `scp /path/to/dst user@host:`
  - `-P [port]`

- `sftp`
  -`sftp -oPort=[port] user@host:directory`

### dns
- `host`
  - `host [host name]` show host info

- `dig`
  - `dig [domain]` show host info
  - `dig NS [domain]` get NS record
  - `dig @[nameserver] [domain]` specify nameserver
  - `dig -x [ip addr]` reverse lookup

## 3.tool
### env
- `awk`

### editor
- `nano`
- `vi`
- `vim`
- `emacs`

### vm
- `vboxmanage`
  - `vboxmanage startvm "vm name" --type headless "vm name"`
  - `vboxmanage list runningvms`
  - `vboxmanage controlvm "vm name" poweroff`
  - `vboxmanage controlvm "vm name" natpf[profile number] "rulename,protocol,hostIP,hostport,gustIP,gustport"`
    - `vboxmanage controlvm "SSH-EXAMPLE" natpf1 "ssh,tcp,127.0.0.1,PORT,,22"`
  - `vboxmanage controlvm "vm name" natpf[profile number]  delete rulename`
  - `vboxmanage showvminfo "vm name"`
  - `vboxmanage modifyvm [same controlvm]` for stopped vms

- `vboxheadless`
  - `-startvm`

### docker
- `docker`
  - `info`
  - `run`
    - `run (image) arg`
  - `images`
  - `build`
    - `build -t (image tag) /path/to/dockerfile/dir/`
  - `tag`
    - `tag (ID) rep/image-name:label`
  - `rmi`
    - `rmi rep/image:tag`
    - `rmi $(docker images | awk '/^<none>/ { print $3 }')`
  - `login`
    - `login --username=user --email=at@mail`
  - `push`
    - `push user/image:tag`
  - `pull`
    - `pull user/image:tag`

### xorg
- `xinit`
- `xrandr`
- `xset`
  - `xset s [off:on}` screen saver
  - `xset [+-]dpms` dpms is Display Power Management Signaling
  - `xset q` query current info

### ADD
TODO: classify
- `tracepath` trace network route
  - `tracepath [ip|domain]`
  - `tracepath -b [ip|domain]`
- `script` save log
  - `script /path/to/log` start saving
- `date`
  - `date "+%Y-%m-%d"`
- `grub`
  - **to MBR**
    1. `grub-install --target=i386-pc <target device /dev/sd?>`
    2. `grub-mkconfig -o /boot/grub/grub.cfg`
  - **MBR & to partition**
    1. `chattr -i /boot/grub/i386-pc/core.img` if exists then modify immutable flag
    2. `grub-install --target=i386-pc --debug --force <target partition /dev/sd??>`
    3. `chattr +i /boot/grub/i386-pc/core.img`
    4. `arch-chroot /mnt && pacman -S linux && grub-mkconfig -o /boot/grub/grub.cfg`
    5. `dd count=1 bs=512 if=/dev/sd?? of=/path/to/boot.img`
  - **if use NT loader, use windows cmd `bcdedit.exe`**
    1. `bcdedit /create /d "diplay name" /application BOOTSECTOR`
    2. `bcdedit /set {store id need brace} device partition=C:` partition is from boot.img
    3. `bcdedit /set {store id} path \path\to\boot.img` boot.img is need readable on the windows
    4. `bcdedit /displayorder {store id} /addlast`
    5. `bcdedit /timeout 10` if needed
    6. **if need delete store** `bcdedit /delete {store id}`
  - **and then remember of fix UTC on the windows after settings**
  - **if grub reinstall(run the grub-install ...), need update the boot.img, use `dd`**
- `git`
  - `git ls-files`
  - `git config --list`
  - `git remote set-url origin git@github.com:USER/rep.git`
  - `git remote set-head [remote] [branch]`
  - `git remote add [remote name] [url]`
  - `git tag -a [tag name] -m "massage"` create new tag
  - `git tag [tag name]` create simple tag
  - `git show [tag name]` show tag info
  - `git branch -a`
  - `git add --interactive`
  - `git add -p /path`
    - **interactive**
      - `?` - show help
      - `y` - stage hunk
      - `s` - split hunk
      - `n` - do not stage
      - `q` - quite
  - `git add -n` --dry-run
  - `git diff HEAD[n] -- /path`
  - `git diff --stat` simple view
  - `git diff --name-only`
  - `git commit -m "msg" -- /path`
  - `git commit --amend` fix recent commit
  - `git log -p /path`
  - `git reflog` manage reflog information
  - `git grep "pattern"` search git repository use grep ignore .git
  - `git clone --no-local /path/to/repo`
  - `git checkout -b [new branch] [remote]/[branch]`
  - `git checkout [branch] [file]` override file from branch to worktree
  - `git checkout .` fallback all files, be careful
  - `git rebase -i HEAD~[n]` interactive rebase, [n]:number of target commits from HEAD
  - `git rebase --abort` abort current rebase
  - `git reset --soft HEAD~[n]`
  - `git reset --hard HEAD~[n]` be careful
  - **bare**
    - `git symbolic-ref HEAD refs/heads/[branch]`
- `tig`
  - `tig status`
- `feh`
- `seq`
  - `[from] [dst]`
- `shuf` shuffle
  - `shuf /path/to/file`
  - `shuf -n 1 /path/to/file` -n lines
- `xclip`
- `sed`
  - `-e` specify script
    - `sed -e 's/word/dst/g'` separator s/ s: s; ...etc
    - `sed -e '1,20s/word/dst/g'` specify lines to replace
    - `sed -i -e 's:word:dst:g' /path/file /path/file2` -i only GNU sed: replace target files
    - `sed -e '1d'` delete first line
    - `sed -e '1p'` puts first line to next
  - `-n` suppress display of origin
    - `sed -n '1,4p'` display first line to four
  - `-f` specify script-file
- `mkinitcpio`
  - `-p [dst preset]`
- `gm` GraphicsMagick forked from ImageMagick
  - `man gm` too many options, see manpage
  - `gm help`
  - `gm convert $in -strip $out` remove profile, author, copyright, and license, be careful
  - `gm mogrify -strip ./*` strip all files in pwd
- `ffmpeg` encoder
  - `ffmpeg -h full` show full help
- `ffprobe $in` show file info
- `free`
  - `free -m` show memory state
- `mplayer`
  - `mplayer -ao null -vo null` audio video
- `npm` package manager for nodejs
  - `npm help`
  - `npm config edit` edit/create .npmrc
  - `npm -g install [pkg]` -g global use flag prefix=
  - `npm -g install [pkg] --save-dev` save dev info in package.json
  - `npm -g list` list installed packages
  - `npm config list`
- `iconv` convert encoding
  - `iconv -f [from enc] -t [taget enc] /path/to/file`
  - `iconv --list` list encoding
  - `iconv -f Shift-JIS -t UTF8 ./file.txt > out.txt`
