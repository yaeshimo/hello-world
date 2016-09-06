/*
リポジトリのルートで
go run addtree.go
./tree.txtの内容をREADME.mdに追加する
追加位置はREADME.md内の以下の部分

```txt:./tree.txt
<追加位置>
```

README.md内に
```txt:./tree.txt
が見つからなければ書き込まない
追加位置にある文字列は上書きされる
*/

/* TODO LIST */
// DONE:カレントディレクトリからREADME.mdを掴んでbufferを作る
// test:bufferの内容をそのまま出力して確認

// DONE:buffer内を1行ずつ確認
// test:bufferを1行ずつ行番号を付けて出力して確認

// DONE:```txt:./tree.txt の前とその後の ``` 後でbufferを分割する string[2]
// DONE:```txt:./tree.txt ``` のブロックが見つからなければexitする
// test:parseしたbufferを2つずつ分けて出力して確認

// DONE:tree.txtを掴んでbuffer3を作る
// test:buffer3を出力して確認

// DONE:newBuffer := string[0]+blockBegin+buffer3+blockEnd+string[1]
// test:新しいbufferの内容を出力して確認

// DONE:新しいbufferをREADME.mdにテキストで出力する

package main

import (
	"bufio"
	"fmt"
	"os"
)

// default
const (
	readme = "./README.md"
	tree = "./tree.txt"

	beginBlock = "```txt:./tree.txt"
	endBlock = "```"
)

type buffer struct {
	readme, tree []string
	block treeBlock
}
func (b *buffer) blockBegin() int { return b.block.beginLine }
func (b *buffer) blockEnd() int { return b.block.endLine }

// README.md 内でtreeBlockを見つけていればtrueを返す
func (b *buffer) existsBlock() bool { return  b.block.in && b.block.exit }

// README.md内のtreeBlockの位置
type treeBlock struct {
	beginLine, endLine int
	in, exit  bool
}
// block開始位置の判定 現状戻り値のboolは使ってない
func (b *treeBlock) setBegin(s string, line int) bool {
	if b.in { return false }
	if s == beginBlock {
		b.in = true
		b.beginLine = line
		return true
	}
	return false
}
// block終了位置の判定 現状戻り値のboolは使ってない
func (b *treeBlock) setEnd(s string, line int) bool {
	if b.exit { return false }
	if s == endBlock && b.in {
		b.endLine = line
		b.exit = true
		return true
	}
	return false
}

// README.md parse and return string
func getReadme() ([]string, error) {

	buf := new(buffer)

	// file reamde
	file, err := os.Open(readme)
	if err != nil {
		fmt.Fprintf(os.Stderr, "file open error %q\n", err)
		return nil, err
	}
	defer file.Close()

	// Scanner readme
	fmt.Println("Scanning README.md")
	for sc, i := bufio.NewScanner(file), 0; sc.Scan(); i++ {
		if err := sc.Err(); err != nil {
			fmt.Fprintf(os.Stderr, "sc.Scan error %q\n", err)
			return nil, err
		}
		buf.block.setBegin(sc.Text(), i)
		buf.block.setEnd(sc.Text(), i)

		buf.readme = append(buf.readme, fmt.Sprintln(sc.Text()))
	}
	if !buf.existsBlock() {
		return nil, fmt.Errorf("not find tree Block in README.md")
	}

	str := make([]string, 2)
	for _, s := range buf.readme[:buf.blockBegin()] { str[0] += s }
	for _, s := range buf.readme[buf.blockEnd()+1:] { str[1] += s }

	return str, nil
}

// return string
func getTree() (string, error) {

	buf := new(buffer)

	// file tree
	file, err := os.Open(tree)
	if err != nil {
		fmt.Fprintf(os.Stderr, "getTree() file open error %q\n", err)
		return "", err
	}
	defer file.Close()

	// scanner tree
	fmt.Println("Scanning tree.txt")
	for sc := bufio.NewScanner(file) ; sc.Scan(); {
		if err := sc.Err(); err != nil {
			fmt.Fprintf(os.Stderr, "sc.Scan() error %q\n", err)
			return "", err
		}
		buf.tree = append(buf.tree, fmt.Sprintln(sc.Text()))
	}

	var str string
	for _, s := range buf.tree { str += s }
	return str, nil
}

// join buffers
func joinText(readme []string, tree string) string {
	if len(readme) != 2 {
		fmt.Fprintln(os.Stderr, "joinText() readme lnegth over")
		return ""
	}
	str := readme[0]
	str += fmt.Sprintf("\n%s\n\n", beginBlock)
	str += tree
	str += fmt.Sprintf("\n%s\n\n", endBlock)
	str += readme[1]
	return str
}

// Write Readme
func writingReadme(s string) {

	file, err := os.Create(readme)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		return
	}
	defer file.Close()

	w := bufio.NewWriter(file)
	n, err := w.WriteString(s)
	if err != nil {
		fmt.Fprintln(os.Stderr, "write error write bytes ", n, err)
		return
	}
	if err := w.Flush(); err != nil {
		fmt.Fprintln(os.Stderr, "Flush error", err)
		return
	}
}

// 上書きの確認
func ask() bool {

	fmt.Println("this string to override at README.md")
	fmt.Printf("[yes:no]? >>")
	for sc, i := bufio.NewScanner(os.Stdin), 0;sc.Scan() && i < 2;i++ {
		switch sc.Text() {
		case "yes": return true
		case "no": return false
		default:
			fmt.Println(sc.Text())
			fmt.Printf("[yes:no]? >>")
		}
	}
	return false
}

func main() {

	bufReadme := make([]string, 2)
	bufReadme, err := getReadme()
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		return
	}

	bufTree, err := getTree()
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		return
	}

	str := joinText(bufReadme, bufTree)
	fmt.Println(str)
	if !ask() {
		fmt.Println("don't write ...process exit")
		return
	}
	writingReadme(str)
}

