# utils
vim: expandtab :  
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

## bash
- `for`
  ```sh
  for x in {0..10}; do
    echo "${x}"
  done
  ```

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

- variable
  - set
    - `var="string"`
    - `var=1` integer
  - out
    - `$var`
    - `${var="if var is not used then return and to into var this msg"}`
    - `${var:="if var is null or empty then"}` if used and not null then only return msg
    - `${var-"if var is not used then return this msg"}` only return, not to into variable
    - `${var:-"if var is null or empty then"}` only return
    - `${var+"if var is used then return"}` allow null
    - `${var:+"if var is used and not null then"}` not allow null, but case of null is returned null
  - special
    - `$?` have exit code
    - `$!` background pid
    - `$-` set flags
    - `$$` self pid
    - `$#` argc
    - `$*` argv
    - `$@` argv
    - `$LINENO` linumber of just used this variable
    - `$0` self name of command
    - `$1` argv[1]
    - `$2` argv[2]
    - `${10}` argv[10], is need brace

- `[command] &` シェルコマンドの終了を待たずにバックグランドジョブになる
  - `echo "hi" & & echo "foo"` error
  - `unset var ; echo "hi" & $var & echo "foo"` non error
- `fg [job_id]` to foreground
- `jobs` show background jobs
- `[(command)]` subshell
- `history` コマンドの履歴を表示　![ヒストリー番号]　で実行
  - `history 100` show one hundred histories
  - `![number]` run
- `man` open manual
  - `man [:digit:] [dst command]`
- `whatis` description of one line
  - `whatis [command]`
- `reset` reboot terminal
- `command` shell builtin
  - `command [cmd]` avoid alias
  - `command -v [cmd]` witch
- `test` if true then return exit code is 0
  - `test -f /path/file` regular file
  - `test -d /path/dir/` directory
  - `test -r /path` readable
  - `test -w /path` writable
  - `test -x /path/exe` executable
  - `test "$str" = "str"` have same string
  - `test "$str" != "str"` have not same string
  - `test -n "$str"` have string
  - `test -z "$str"` don't have string
  - `test 0 -eq 0` equal
  - `test 1 -ne 0` not equal
  - `test 0 -lt 1` less than, <
  - `test 0 -le 1` less equal, <=
  - `test 1 -gt 0` greater than, >
  - `test 1 -ge 0` greater equal, >=
- `[` same test
  - `[ -f /path/file ]`
- `[[` bash only, like test

- `declare` list of declaration
  - `declare -f` list functions
    - `declare -f ${fnc_name}` show content of function
  - `declare -F` function name only

### on bash
- `shopt` check bash options
- `compgen` complete generate

### fstab
```fstab
# for ext4
# UUID=uuid	/point	ext4	nofail,rw,user,relatime,data=ordered	0 2
# for ntfs
# UUID=uuid	/point	ntfs	nofail,rw,user,relatime,uid=user,gid=user,dmask=022,fmask=133	0 0
```

### limitation of directory
```sh:limitation
# require root
### limitation of directory
# create vurtual disc
dd bs=1M count=512 if=/dev/zero of=/path/to/limitation.fs
# format
mke2fs -t ext4 /path/to/limitation.fs
# mount
mount -o loop -t ext4 /path/to/limitation.fs /target/limitation/directory

### optional, add to fstab
cat <<END >> /etc/fstab
# for limitation of directory
/path/to/limitation.fs /target/limitation/directory ext4 defaults,loop 0 0 >> /etc/fstab
END
```

**force command**
```
vim /etc/ssh/sshd_config
```

```conf:sshd_config
# append sftp only
Match User .*
	ForceCommand sftp-server
	AllowTcpForwarding no
	X11Forwarding no
# if need chroot
Match User .*
	ChrootDirectory %h # require directory by root owned
	ForceCommand internal-sftp
	AllowTcpForwarding no
	X11Forwarding no
```

### config sample
`ssh_config`
```conf
Host hostname
  IdentitiesOnly yes
  IdentityFile ~/.ssh/private_key
  Port 22

Host alias_of_locale_host
  HostName 192.168.1.1
  Port 8080

Host another
  Port 8080

Match *-lily
  IdentityFile ~/.ssh/private_key
# ...etc
```

## commands
1. file
2. system
3. tool

## 1.file

### permission
- `rwx`
  - `r` read, bit 4
  - `w` write, bit 2
  - `x` execute, bit 1
  - bit
    - `r--` bit 4
    - `100
    - `rw-` bit 6
    - `110`
    - `rwx` bit 7
    - `111`

### リダイレクト
- `>` 出力のリダイレクト 上書き
- `>>` 出力のリダイレクト 追記
- `<` 入力のリダイレクト
- `<<` 終了文が現れるまで標準入力へ送る(<<[終了文の指定]) ヒアドキュメント
- `<(command)` プロセス置換 コマンドの出力結果をファイルとして扱う
- `|` 左のコマンドの出力結果を右のコマンドに引き渡す パイプ
- `|&` 標準エラーも含めてパイプに渡す
- `>&1` ファイルディスクリプタ1番 標準入力
- `>&2` ファイルディスクリプタ2番 標準エラ-出力
- `1>` 標準出力 ファイルディスクリプタ1番のリダイレクト
- `2>` 標準エラ-出力 ファイルディスクリプタ2番のリダイレクト

- `: > file` file to empty

### ヒアドキュメント: Here document
```sh
cat <<'END'
this is Here document ${HOME}
END

# variable expansion
cat <<END
this is Here document ${HOME}
END
```

### 検索や表示、作成
- `ls` list directory and files
- `lscpu` list cpu information
- `lsmem` list memory information
- `lspci` list PCI
- `lsblk` list block device
  - `lsblk -f` with uuid
  - `lsblk --fs` same -f
  - `lsblk -no UUID /dev/sdXN` check uuid
- `lsattr` list attributes
- `lslogins` list login state
- `lsns` list name space
- `lsipc` list IPC information
- `lsmod` list module information
- `lsusb` list USB information
- `dir`
- `dirs` show directories
- `pwd` show current dir
- `file`
- `stat` return file information
  - `stat /path/file`

- `df` show disk cap
  - `df -h`
- `du` show dir size
  - `du -h`
  - `du -h -s` only total
  - `du -h --max-depth=0` check only current directory

- `cat` binaryを読むと表示が崩れる
  - `reset`でterminalを再起動すると回復するかも
  - proc
    - `cat /proc/cpuinfo` get cpuinfo
    - `cat /proc/meminfo` get memory information
    - `cat /proc/sys/kernel/random/entropy_avail` check entropy
- `zcat` cat for compressed files
  - `zcat /proc/config.gz`
- `more`
- `less [file]`
  - ` less -N [file]` add line number

- `locate` インデックスの作成は`sudo updatedb`
- `find`
  - `find . -name "${match}"`
- `grep`
  - `grep "${match}" /path/file`
  - `grep -A 2 -n -e "${match}"` show pattern after 2 lines
  - `grep -C 2 -n -e "${match}"` show pattern 2 lines before and after
  - `grep -v -e "${match}" -- "file"` invert match
  - `grep --line-number --with-filename --regexp "${match}" -- "${/path/file}"`
- `tee` 渡された内容を標準出力とファイルに書き込む
  - `${cmd} | tee /path/file`
  - `${cmd} 2>&1 | tee /path/file` tee with stderr
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
  - `tar xf /path/archive.tar.xxx` extract
  - `tar vxf /path/archive.tar.xxx` with verbose
    - `tar --verbose --extract --file /path/archive.tar.xxx`
  - `tar cvaf out.tar.gz /path/dir` create archive
    - `tar --verbose --create --xz --file out.tar.xz /path/dir`
  - `tar --help`
  - **Flags:**
    - `x` extract
    - `c` create
    - `a` create archive auto compress from filename
    - `z` create archive gzip [.gz]
    - `f` specify file or archive
    - `v` verbose

### TODO: classify
- `mkdir`
- `rmdir`
- `rm`
- `mv`
- `cp`
- `dd`
  - `dd count=N bs=N if=/path of=/path`
  - `dd if=/input of=/output status=progress` with progress
- `wc` print line, word, byte count
  - `wc -l /path/file` cout lines
- `xargs` generate command line
  - Example
    - ```ls *.go | xargs head```
    - `git ls-files | xargs wc -l`
  - Be careful
    - `rm, mv, dd, ...etc.`


## 2.system
- `dmesg`
  - `dmesg --follow` wait for new messages
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
  - `systemctl --help` show help
  - `systemctl status`
  - `systemctl reboot`
  - `systemctl poweroff`
  - `systemctl daemon-reload`
  - `systemctl list-unit-files`
  - `systemctl list-timers`
  - `systemctl is-${active|enabled} ${service|timer}`
  - `systemctl ${start|stop|enable|disable} ${service|timer}`
  - `systemctl --user ${command}` systemctl with user flag
    - `systemctl --user reset-failed ${service}`
    - `systemctl --user show-environment` list environments
- `sysctl` for kernel parameter
  - `sysctl -a` list kernel parameter
- `systemd-cgtop` top of cgroups
- `systemd-analyze`
  - `systemd-analyze --user set-log-level [loglevel]` loglevel: info, notice, ...
- `bootctl` systemd-boot for EFI boot
- `systemd-nspawn` virtual machine
  - **make container**
    - `sudo mkdir /path/to/container` remember need to root
    - `sudo pacstrap -i -c -d /path/to/container base --ignore linux`
    - `sudo systemd-nspawn -b -D /path/to/container`
  - `systemd-nspawn -b -D ./container` -b boot -D directory
  - `systemd-nspawn -b -n -D ./container` -n create virtual Ethernet link
  - `systemd-nspawn -b -D ./container --network-bridge=[interface name of bridge]`
  - `systemd-nspawn -b -D ./container --bind=/tmp/.X11-unix/X0` bind for X, check :ls /tmp/.X11-unix
    - `export DISPLAY=[host display]` on container
- `machinectl`


### journal
- `journalctl`
  - `journalctl -u [unit]` specify unit
  - `journalctl -f` follow
  - `journalctl --user-unit=dst.[service:...]`
  - `journalctl -p [priority:number or label]`

- `logger` output to syslog
  - `logger 'hello'` pre journalctl -f

### process
- `ps`
  - `ps auxf`
- `pstree`
  - `pstree -p` with pid
- `top` show system information
- `htop` show system information
- `pgrep` check process id
  - `pgrep ${pattern}`
- `pkill`
  - `pkill ${pattern}` kill from name
- `kill`
  - `kill ${pid}`
- `killall`
  - `killall ${process_name}`

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
- `su` switch user
  - `su` carry the current user environment to root
  - `su -` to root, use login shell
  - `su [user name]` carry the current user environment
  - `su - [user name]` use login shell
- `sudo`
  - `sudo --list` list allowed commands
  - `sudo -K` remove timestamp
  - `sudo -u [switch user] [command]`
- `chmod`
  - `chmod [ugo][+-=][rwx] /path/to/target`
  - `chmod u+s /path/to/execute` set SUID
  - `chmod g+s /path/to/directory/` set SGID
  - `chmod o+t /path/to/directory/` set stickybit
  - `chmod --recursive a=rX,u+w ${path/dir}` recursively change the mode to dmask=022 fmask=133
  - mode `[ugoa][+-=][rwx],...`
    - target
      - `a` all
      - `u` user
      - `o` other
    - allows
      - `r` read
      - `w` write
      - `x` execute
- `chown`
  - `chown user:group /dif/or/file/`
- `passwd`
  - `passwd ${username}`
  - `passwd -l ${user name}` lock password
  - `passwd -u ${user name}` unlock password
  - `passwd -d ${user name}` delete password
- `pwck`
  - `pwck -s` sort /etc/passwd
- `visudo` edit /etc/sudoers
- `vipw` edit /etc/passwd
- `vigr` edit /etc/group

### user
- `id` show user info
- `users` show current user
  - `cat /etc/passwd` show all users
- `useradd`
  - `useradd -m -G ${append_group} -s /default/shell ${user_name}` -m is make home
  - `useradd -d ${path/homedir} -G ${append_group} -s /default/shell ${user_name}`
  - `useradd -M -s /usr/bin/nologin [user name]`
- `usermod` modify user
  - `usermod -s /path/to/shell`
  - `usermod -l ${new_name} ${old name}` change login name
  - `usermod -d /new/home/ -m ${user_name}` make new home directory from [user name]
  - `usermod -aG ${additional_groups} ${user_name}` add group
- `userdel`
  - `userdel -r ${user_name}`
- `groups`
  - `groups ${user_name}` show user groups
  - `cat /etc/group` show system groups
- `groupadd ${group_name}` add group
- `groupdel ${group_name}` delete group
- `chgrp`
  - `chgrp ${group_name} /dir/or/file`
- `gpasswd`
  - `gpasswd --add ${user} ${group}`
  - `gpasswd --delete ${user} ${group}`
- `groupmod`
  - `groupmod -n ${new_name} ${old name}`
- `getent`
  - `getent group wheel` check wheel
  - `getent hosts` check hosts

### パーティション操作
- `fdisk`
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

- `wipefs` be careful
  - `wipefs --all /path/device`
- `mkfs.ext4`

- `blkid`
  - `blkid -s PARTUUID` check part uuid

### マウント
- `mount`
  - `mount /dev/sdaN /mnt` mount device
  - `mount --bind /path/from /path/to` mount directory
  - `mount --rbind /path/fromroot /path/to` recursive bind mount
    - bind mount
    ``` sh
    mount --bind /path/from0 /path/root/dir0
    mount --bind /path/from1 /path/root/dir1

    mount --rbind /path/root /path/to
    ls /path/to # dir0 dir1
    ```
- `umount` unmount
  - `umount /path/dir`

### 設定されている環境変数を調べる
- `printenv`
  - `printenv ${variable}`
- `env`


### link
- `ln`
  - `ln /from /linkname` make hard link
  - `ln -s /from /path/linkname` make symbolic link
  - `ln -s /from /path/` make symbolic link in /path
  - `ln -sfn /from/ /link` if /link is symbolic link of to directory, then override it
- `unlink` be careful if specify regular file then is remove it
- `readlink`
  - `readlink /path/link`
  - `readlink -f /path/file/or/link`
- `which`
  - `which "command name"`

### ネットワーク
- `ss`
  - `ss -tnlp` show tcp listen ports
  - `ss -atn` show tcp state
- `ip`
- `ping`
- `tcpdump`
  - `tcpdump port [number]` specify port
  - `tcpdump port not ssh and port not llmnr` specify ignore port
  - `tcpdump -i br0` specify interface
  - `tcpdump -n -vvv port not ssh and port not llmnr`
  - `tcpdump -Z [user]` drop privilege of root after enable promiscuous mode
  - `tcpdump -p` not use promiscuous mode
  - `tcpdump -A` show content with ASCII
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
  - `nft list ruleset` list ruleset
  - `nft list ruleset -a` with handler number
  - `nft flush ruleset` delete current ruleset
  - `nft -f ${path/rule}` append rule from file
  - control rules
    - `nft add rule ${family} ${table} ${chain} tcp dport ${ssh/22} accept` accept ssh
      - `nft add rule inet filter input tcp dport 3000 accept` accept inet on input chain port 3000
    - `nft add rule ${family} ${table} ${chain} position  ${handler_number} tcp dport ${port_number} accept` use handler
      - `nft add rule inet filter input position  8 tcp dport http-alt accept` accept http-alt with specific handler
      - `nft add rule inet fileter input position 8 ip saddr 192.168.1.10 tcp dport http-alt accept` accept only from 192.168.1.10
    - `nft delete rule ${family} ${table} ${chain} handle ${handler_number}` delete rule
- `curl`
  - `curl -o /out/file ${url}` output file
  - `curl -O ${url}` output file with remote name
  - `curl -v ${url}` verbose
  - `curl -vv ${url}` more verbose
  - `curl -I ${url}` info only

### ssh
- `ssh`
  - `ssh user@host`
  - `ssh -A [user]@[host]` enable agent forwarding
  - `ssh -p [port] -i /path/to/key [user]@[host]`
  - `ssh [alias]` use preset into .ssh/config

- `ssh-keygen`
  - `ssh-keygen -t rsa -b 4096 -C "comment"`
  - `ssh-keygen -t ecdsa -b 521 -f ~/.ssh/private -C "comment"` not -b 512
  - `ssh-keygen -t ed25519 -f ~/.ssh/private-id_ed25519 -C "comment"`
  - `ssh-keygen -p -f ~/.ssh/private` modify passphrase
  - `ssh-keygen -c -f ~/.ssh/private` modify comment
  - `ssh-keygen -R [host]` delete from known hosts

- `ssh-agent`
  - `eval "$(ssh-agent)"`

- `ssh-add`
  - `ssh-add -l`
  - `ssh-add /path/to/privatekey`

- `keychain`
  - `keychain [private-key,another-key]`
  - `keychain --help`
  - `eval $(keychain --eval --quit [key])`

- `scp`
  - `scp /path/to/src user@host:` copy to user@host:
  - `scp user@host:file.txt /path/to/dst` copy to /path/to/dst
  - `scp -P [port] /path/to/src user@host:` specify port number

- `ssh-copy-id` copy to authorized
  - `ssh-copy-id -i /path/to/key.pub [user]@[host]`
  - `ssh-copy-id -i /path/to/key.pub -p [port number] [user]@[host]`

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
  - `vim -- /path/file` edit
  - `vim -c "help"` run Ex command after startup
  - `vim -u NONE -- /path/file` disable vimrc
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
  - `xset r [delay] [rate]` modify keyrepeat
    - `xset r 200 30`
- `xhost`
  - `xhost +local:` enable
  - `xhost -` disable
- `xinput`
  - `xinput list` show device tree
  - `xinput list-props ${devNumber}`
  - `xinput set-prop ${devNumber} ${optionNumber} ${setting}`

### package manager
- `pacman`
  - `pacman --help` show help message
  - `pacman -S --help` help for -S
    - `pacman -S ${pkg_or_group}` install
    - `pacman -S --force ${pkg_or_group}` update with force, be carful
    - `pacman -Si ${pkg}` information
    - `pacman -Ss ${search_word}` search package
    - `pacman -Syu` system upgrade
    - `pacman -Sc` remove cache
  - `pacman -R --help` help for -R
    - `pacman -R ${pkg}` remove package
    - `pacman -Rs ${pkg}` remove package with depend
  - `pacman -Q --help` help for -Q
    - `pacman -Qo ${path_file}` check owned
    - `pacman -Ql ${pkg}` list of the files installed by a package
    - `pacman -Qdt` find standalone package
- `pacman-optimize` optimize database for pacman
- `checkupdates` package update checker for pacman
- `pacstrap`
  - `pacstrap -i -c -d /path/dir --ignore linux` for nspawn
- `pactree` show dependency
  - `pactree "${pkg}"`
- `paccache`
  - `paccache -r` remove cache but still keep the recent 3 versions

### TODO: classify
- `traceroute` trace network route
  - `traceroute ${ip/hostname}`
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
  - **update**
    - `chattr -i /boot/grub/i386-pc/core.img`
    - `grub-install --target=i386-pc --debug --force [install boot partition, example: /dev/sda6]`
    - `chattr +i /boot/grub/i386-pc/core.img`
    - `grub-mkconfig -o /boot/grub/grub.cfg`
    - **for NT loader**
      - `mount [device of win, example: /dev/sda3] /mnt`
      - `dd count=1 bs=512 if=[grub boot partition, example: /dev/sda6] of=[for NT loader] && sync`
      - `umount /mnt`
- `git`
  - `git ls-files`
  - `git config --list`
  - `git remote`
    - `git remote -v` show remote info
    - `git remote add ${remote_name} ${url}`
    - `git remote set-url ${remote_name} git@github.com:USER/rep.git` set github repository
    - `git remote set-head ${remote_name} ${branch}`
  - `git tag`
    - `git tag -a ${tag_name} -m "massage"` create new tag
    - `git tag ${tag name}` create simple tag
  - `git show ${tag name}` show tag info
  - `git branch` manage branch
    - `git branch` list local branches
    - `git branch --help` show help
    - `git branch --all` list remote and local branches
    - `git branch ${new_branch}` create new branch from current HEAD
    - `git branch --delete ${branch}` delete branch
    - `git branch --move ${new_branch_name}` rename current branch name
  - `git add`
    - `git add --interactive`
    - `git add -p /path`
      - **interactive**
        - `?` - show help
        - `y` - stage hunk
        - `s` - split hunk
        - `n` - do not stage
        - `q` - quite
    - `git add --dry-run .` dry run
    - `git add -n .` same --dry-run
  - `git commit`
    - `git commit -m "msg" -- /path`
    - `git commit --amend` fix recent commit
  - `git push` push to remote
    - `git push ${remote} ${branch}` push branch to remote
    - `git push --set-upstream ${remote} ${branch}` push with set upstream
    - `git push --all ${remote}` push all branches to remote
  - `git diff`
    - `git diff HEAD~[n] -- /path` [n] is number
    - `git diff --stat` simple view
    - `git diff --name-only`
  - `git log`
    - `git log -p /path`
    - `git log --stat` with commit status
  - `git reflog` manage reflog information
  - `git grep` grep on git repository
    - `git grep -e "pattern"` search git repository use grep ignore .git
    - `git grep "${match_word}" -- ${pattern_files}`
  - `git clone`
    - `git clone --no-local /path/to/repo`
    - `git clone --branch=${branch_or_tag} /path/from.git /path/to` specify clone branch
  - `git checkout`
    - `git checkout -b ${new_branch} ${remote}/${branch}`
    - `git checkout ${branch} ${file}` override file from branch to worktree
    - `git checkout .` fallback all files, be careful
  - `git merge`
    - `git merge ${from}` merge branch
    - `git merge --no-ff ${from}` make merge commit
  - `git rebase`
    - `git rebase -i HEAD~[n]` interactive rebase, [n] is number of target commits from HEAD
    - `git rebase --abort` abort current rebase
  - `git reset` modify current HEAD
    - `git reset HEAD~[n]` reset with index
    - `git reset --soft HEAD~[n]` reset only position of HEAD
    - `git reset --hard HEAD~[n]` be careful, reset with index and worktree
  - `git worktree`
    - `git worktree list` list worktree
    - `git worktree add ${path/dir} ${branch}` create worktree
    - `git worktree prune` prune refference of empty worktree
  - `git rev-parse`
    - `git rev-parse --show-toplevel` print git root directory
  - **bare**
    - `git symbolic-ref HEAD refs/heads/[branch]`
- `tig`
  - `tig status`
- `feh`
  - `feh --cycle-once --scale-down --slideshow-delay [num] [dir]`
- `seq`
  - `[from] [dst]`
- `shuf` shuffle
  - `shuf /path/to/file`
  - `shuf -n 1 /path/to/file` -n lines
  - `shuf -i 1-100 -n 1` get random number 1-100
- `xclip`
  - `xclip -o` output
  - `xclip -o | xclip -selection clipboard -i` copy to clipboard
- `sed`
  - `sed --in-place=".back" --expression="s/word/dst/" /path/file` create backup with suffix ".back" and to overwrite
  - `sed -e` specify script
    - `sed -e 's/word/dst/g'` separator s/ s: s; ...etc
    - `sed -e '1,20s/word/dst/g'` specify lines to replace
    - `sed -i -e 's:word:dst:g' /path/file /path/file2` -i only GNU sed: replace target files
    - `sed -e '1d'` delete first line
    - `sed -e '1p'` puts first line to next
    - ``sed -e 's/^#\(.*\)/\1/' /path/file`` trim comment prefix
    - `sed -e '/word/a hello' /path/file` add hello after find word
  - `sed -n` suppress display of origin
    - `sed -n '1,4p'` display first line to four
  - `sed -f` specify script-file
- `mkinitcpio`
  - `-p [dst preset]`
- `gm` GraphicsMagick forked from ImageMagick
  - `man gm` too many options, see manpage
  - `gm help`
  - `gm convert $in -strip $out` remove profile, author, copyright, and license, be careful
  - ``gm mogrify -strip ./*`` strip all files in pwd
- `ffmpeg` encoder
  - `ffmpeg -h full` show full help
  - `ffmpeg -i /path/src.ext /path/out.ext` convert
  - `ffmpeg -i /path/src.mp4 /path/out.flac` convert to flac
  - `cat media.mp4 | ffmpeg -i pipe:0 out.flac` use pipe
  - screencast
    - `ffmpeg -f x11grab -follow_mouse centered -framerate 25 -video_size cif -i ${DISPLAY} out.mpg`
    - `ffmpeg -f x11grab -follow_mouse 100 -framerate 25 -video_size cif -i ${DISPLAY} out.mpg`
    - `ffmpeg -f x11grab -show_region 1 -framerate 60 -video_size cif -i ${DISPLAY}+10,20 out.webm`
    - `ffmpeg -f x11grab -follow_mouse centered -show_region 1 -framerate 25 -video_size cif -i ${DISPLAY} out.webm`
    - `ffmpeg -f x11grab -follow_mouse centered -framerate 25 -video_size 600x600 -i ${DISPLAY} out.webm`
- `mediainfo` show media information
  - `mediainfo ${path_media}` show media information
- `ffprobe $in` show file info
- `free`
  - `free -m` show memory state
- `vmstat` check virtual memory state
- `mplayer`
  - `mplayer -ao null -vo null` audio video
  - `mplayer example.mp4 -idle -fixed-vo` keep open the window
  - `mplayer -ao pulse -dvd-device /path/iso -mouse-movements dvdnav://` open dvd /path/iso or /dev/sr0
  - `mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video${number} -fps 15 -vf secreenshot` capture from camera
- `mpv`
  - `mpv /path/media`
  - `mpv --shuffle --loop-playlist=${number} /path/dir`
  - `mpv av://v4l2:/dev/video${number}` capture from camera
- `npm` package manager for nodejs
  - `npm help`
  - `npm config edit` edit/create .npmrc
  - `npm -g install [pkg]` -g global use flag prefix=
  - `npm -g install [pkg] --save-dev` save dev info in package.json
  - `npm -g update` update all packages
  - `npm -g uninstall [pkg]` uninstall
  - `npm -g list` list installed packages
  - `npm config list`
- `iconv` convert encoding
  - `iconv -f [from enc] -t [taget enc] /path/to/file`
  - `iconv --list` list encoding
  - `iconv -f Shift-JIS -t UTF8 ./file.txt > out.txt`
- `tmux` terminal multiplexer
  - `tmux ls` list sesstions
  - `tmux attach` attach the session
  - `tmux a -t ${number}` specify attach session
  - **in tmux**:`<C-b>` send prefix(default)
    - `?` list keys
    - `d` detach client
    - `x` kill pane
    - `<C-z>` suspend client, `fg` then return
    - `s` show session tree
    - `(` switch previous session
    - `)` switch next session
    - `c` create new window
    - `l` focus last window
    - `n` next window
    - `p` previous window
    - `[number]` switch window
    - `"` split pane
    - `%` vsplit pane
    - `;` focus last pane
    - `[` to copy mode
    - `]` paste current buffer
    - `#` list copy buffer
    - `=` select buffer then paste
    - `:` tmux command mode
      - `list-keys` list bind keys
- `nm` list symbols from object files
  - `nm ${path_object}`
- `nmap` port scan, careful use it
  - `nmap ${Domain/Address}` be careful
    - `nmap localhost` scan localhost
    - `nmap 192.0.2.0/24` scan between 192.0.2.1-256
    - `nmap 192.0.2.2-10` scan between 192.0.2.2-10
    - `nmap 192.0.2.5,7,10-12` scan 5,7,10,11,12
  - `nmap -p ${%d}-${%d} ${Domain/Address}` specify scan port, %d is integer
    - `nmap -p 0-65535 ${Domain/Address}` scan between 0-65535
    - `nmap -p 22,80,81-100 ${Domain/Address}`
  - `nmap -sL ${Domain/Address}` list scan addresses, is not send packets
  - `nmap -sP ${Domain/Address}` ping scan only
  - `nmap -oN /path/out.txt ${Domain/Address}` out to file
- `strings` print printable characters
  - `strings /path/file` print printable content of files
- `hostnamectl`
  - `hostnamectl status`
  - `hostnamectl set-hostname`
- `bundle` the gem of ruby
  - `bundle init` create Gemfile
  - `bundle install --path ./vendor/bundle` install in ./vendor/bundle from Gemfile
  - `bundle exec rails new .` make rails on project directory
- `rails` the gem of ruby
  - `rails new .` make rails on project directory
- `dot` graphviz
  - `dot /path/to/src.dot`
  - `dot -Tpng /path/to/src.dot -o /path/to/out.png` make image from dot src
- `diff`
  - `diff file1 file2`
- `cmp` diff for binary
  - `cmp file1 file2`
  - `cmp [--verbose/-l] file1 file2`
- `zdiff` diff for compressed files
- `zcmp` diff for compressed files
- `dirname` get directory name
  - `dirname $0` get name of parent directory
- `basename` get base name
  - `basename $0` get base name
- `who` login history
- `w` just like who
- `truncate`
  - `truncate /path/file --size 0` file to empty
- `go`
  `go test -v -cover` show cover from current directory
  `go test -v -coverprofile=cover.prof` make cover profile
  `go tool cover -html=cover.prof` to html
  `go test -v -race` check race condition

- TODO fix content `allowOther`
- `sshfs`
  - `sshfs user@host: /path/mnt` mount user home to local mnt
  - `sshfs user@host:/dir /path/mnt` specify remote directory
  - `sshfs user@host: /path/mnt -o allow_other` see /etc/fuse.conf on local, accept read and write
    - if need non root, require comment out `user_allow_other` in /etc/fuse.conf on local
  - `sshfs user@host: /path/mnt -C` use compress
  - `sshfs -o idmap=user user@host: /path/mnt` translate uid for local user
  - `fusermount3 -u /path/mnt` unmount on local

- `rsync`
  - `rsync /path/src /path/dst` copy to dst
  - `rsync -P /src /dst` same --partial --progress
  - `rsync -r /src/dir /dst` same --recursive
  - `rsync -e ssh user@host:src /dst` copy from host use ssh
  - `rsync -P -r -e ssh user@host:src/dir /dst` copy to local
  - `rsync -P -r -e ssh /src user@host:dst/dir` copy to host
- `ethtool` bind network device
  - ``ethtool en*`` show information
- `wol` send magic packet for wake on lan
  - `wol "${targetMacAddress}"` use broadcast
  - `wol -i "${targetIpAddress}" "${targetMacAddress}"` specify taget ip addr
- `ip`
  - `ip link`
  - `ip addr`
  - `ip route`
- `pdfimages`
  - `pdfimages path.pdf path/dir` generate images into path/dir
- `sxiv` image viwer
- `wpa_supplicant`
  - `wpa_supplicant -B -i ${interface} -c /etc/wpa_supplicant/wpa_supplicant-${interface}.conf`
- `wpa_passphrase "${SSID}" "${passphrase}"` out to stdout
- `expr` evaluate expression
  - `expr 1 + 1` 2 `1+1` is invalid
  - `expr 2 - 1` 1 `1-1` return code is !0
  - `expr 4 / 2` 2
  - `expr 4 % 3` 1
  - `expr 3 \* 2` 6 need escape
- `gpg` gnupg
  - `gpg --list-keys` check existing keys
  - `gpg --full-gen-key --expert` generate key pair
  - `gpg --encrypt ${path/file}` encrypt files
  - `gpg --decrypt ${path/file.gpg}` decrypt files
    - `gpg --output ${path/file} --decrypt ${path/file.gpg}` decrypt files then output
- `od` binary dump
- `hexdump` binary dump
- `xxd` binary dump
- `objdump` binary dump
- `readelf` for read information of ELF
- `ldd` check dynamic links from binary

### python
- `python` run python interpreter
  - `python --help` show help
  - `python -m venv` python module venv
    - `python -m venv -h` show help for venv
    - `python -m venv /path/venv/dir` make python virtual environment directory
      - `source /path/venv/dir/bin/activate` activate python virtual environment on bash
        - `deactivate` deactivate current python virtual environment

### golang
- `go` command prefix for golang
  - `go build /path/file` build binary

### rust
- `rustup` boot strap tool for rust
  - `rustup help`
    - `rustup help ${subcommand}`
  - channels=[stable|beta|nightly]
  - `rustup doc` open documents on web browser
  - `rustup update` update current channel
  - `rustup install ${channel}` install new channel
  - `rustup default ${channel}` set default channel
  - `rustup target list` list target platforms
  - `rustup component`
    - `rustup component list` list component
    - `rustup component add rust-src` append rust-src for omni completion
    - `rustup component add rustfmt-preview` for rust fmt
- `rustc` rust compiler
- `cargo` package manager for rust
  - `cargo check`
  - `cargo run`
  - `cargo build`
