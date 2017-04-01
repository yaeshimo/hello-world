package main

import (
	"container/list"
	"fmt"
	"go/token"
	"go/types"
	"math"
	"math/big"
	"sort"
	"strconv"
	"strings"
	"sync"
)

func split(str string) {
	fmt.Println("----------", str, "----------")
}

// forループ、whileループ、および再帰を使用して、リスト内の数字の合計を計算する3つの関数を記述せよ。
func q1() {
	l := list.New()
	for i := 0; i < 16; i++ {
		l.PushBack(i)
	}
	fmt.Println("l.Len:", l.Len())

	fmt.Print("for:")
	var result int
	for n := l.Front(); n != nil; n = n.Next() {
		result += n.Value.(int)
	}
	fmt.Println(result)

	fmt.Print("recuresive:")
	e := l.Front()
	var rec func(*list.Element) int
	rec = func(e *list.Element) int {
		if e == nil {
			return 0
		}
		return e.Value.(int) + rec(e.Next())
	}
	fmt.Println(rec(e))
}

// 交互に要素を取ることで、2つのリストを結合する関数を記述せよ。
// 例えば [a, b, c]と[1, 2, 3]という2つのリストを与えると、関数は [a, 1, b, 2, c, 3]を返す。
func q2() {
	// init test data
	l := list.New()
	l2 := list.New()
	for a, i := 'a', 0; a != 'n'; func() { a++; i++ }() {
		fmt.Println(string(a), i)
		l.PushBack(a)
		l2.PushBack(i)
	}
	fmt.Println("l.Len:", l.Len(), "l2.Len:", l2.Len())

	// answer
	result := func(l, l2 *list.List) *list.List {
		l3 := list.New()
		for e, e2 := l.Front(), l2.Front(); ; {
			if e != nil {
				l3.PushBack(e.Value)
				e = e.Next()
			}
			if e2 != nil {
				l3.PushBack(e2.Value)
				e2 = e2.Next()
			}
			if e == nil && e2 == nil {
				return l3
			}
		}
	}(l, l2)

	// show result
	for e := result.Front(); e != nil; e = e.Next() {
		switch e.Value.(type) {
		case rune:
			fmt.Printf("%c ", e.Value)
		case int:
			fmt.Printf("%d ", e.Value)
		}
	}
	fmt.Println("finish")
}

// 最初の100個のフィボナッチ数のリストを計算する関数を記述せよ。
// 定義では、フィボナッチ数列の最初の2つの数字は0と1で、次の数は前の2つの合計となる。
// 例えば最初の10個のフィボナッチ数列は、0, 1, 1, 2, 3, 5, 8, 13, 21, 34となる。
func q3() {
	fib := func(i uint) []*big.Int {
		fib := make([]*big.Int, i)
		for i := range fib {
			fib[i] = new(big.Int)
		}
		fib[0].SetInt64(0)
		fib[1].SetInt64(1)
		for i := uint(2); i < uint(len(fib)); i++ {
			fib[i].Add(fib[i-2], fib[i-1])
		}
		return fib
	}
	result := fib(100)
	for i := 0; i < len(result); i++ {
		fmt.Printf("%2d: %s\n", i, result[i])
	}
}

// 正の整数のリストを与えられたとき、数を並び替えて可能な最大数を返す関数を記述せよ。
// 例えば、[50, 2, 1, 9]が与えられた時、95021が答えとなる。
func q4() {
	// test data
	l := list.New()
	for _, x := range []uint{50, 2, 1, 9} {
		l.PushBack(x)
	}

	// make uint slice
	ul := make([]uint, l.Len())
	for i, e := 0, l.Front(); e != nil; i, e = i+1, e.Next() {
		v, ok := e.Value.(uint)
		if !ok {
			panic(fmt.Errorf("error: can't e.Value.(uint)"))
		}
		ul[i] = v
	}

	// (,,ﾟДﾟ) 問題のリストの意味はリスト型? なら引数をリスト型に変える
	// とりあえずこのまま
	swapMax := func(ul []uint) string {
		// pre require
		sort.Slice(ul, func(i, j int) bool {
			return ul[i] < ul[j]
		})
		// to string slice
		ss := make([]string, len(ul))
		for i, u := range ul {
			ss[i] = strconv.FormatUint(uint64(u), 10)
		}
		// make result
		var result string
		for _, dst := range []string{"9", "8", "7", "6", "5", "4", "3", "2", "1"} {
			for _, s := range ss {
				if strings.HasPrefix(s, dst) {
					result += s
				}
			}
		}
		return result
	}
	fmt.Println(swapMax(ul))
	fmt.Println(swapMax([]uint{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}))
	fmt.Println(swapMax([]uint{10, 9, 8, 7, 6, 5, 4, 3, 2, 1}))
	fmt.Println(swapMax([]uint{4, 2, 3, 1, 10, 5, 6, 8, 7, 9}))
}

// 1,2,…,9の数をこの順序で、"+"、"-"、またはななにもせず結果が100となるあらゆる組合せを出力するプログラムを記述せよ。
// 例えば、1 + 2 + 34 – 5 + 67 – 8 + 9 = 100となる
func q5() {
	// maybe 3**8
	arr := []string{"1", "2", "3", "4", "5", "6", "7", "8", "9"}
	fmt.Println(arr)

	// return match pattern strings 1..9 == 100
	result := func(t []string) []string {
		if t == nil {
			return nil
		}
		type node struct {
			Compress  string
			Increment *node // after increment
			Decrement *node // after decrement
			Join      *node // after join
		}
		root := &node{
			Compress: t[0],
		}

		// TODO: nyan: expr
		eval := func(expr string) (types.TypeAndValue, error) {
			return types.Eval(token.NewFileSet(), types.NewPackage("main", "main"), token.NoPos, expr)
		}

		// use Sync.Mutex? yeh
		mux := new(sync.Mutex)
		result := new([]string)

		wg := new(sync.WaitGroup)
		var walker func(*node, []string) // for catch the self
		walker = func(n *node, t []string) {
			defer wg.Done()
			if len(t) == 0 {
				if tv, err := eval(n.Compress); err != nil {
					panic(err)
				} else if tv.Value.String() == "100" {
					mux.Lock()
					*result = append(*result, n.Compress)
					mux.Unlock()
				}
				return
			}
			/// 3ways
			// Increment
			n.Increment = &node{
				Compress: n.Compress + "+" + t[0],
			}
			wg.Add(1)
			go walker(n.Increment, t[1:])
			// Decrement
			n.Decrement = &node{
				Compress: n.Compress + "-" + t[0],
			}
			wg.Add(1)
			go walker(n.Decrement, t[1:])
			// Join
			n.Join = &node{
				Compress: n.Compress + t[0],
			}
			wg.Add(1)
			go walker(n.Join, t[1:])
		}

		wg.Add(1)
		walker(root, t[1:])
		wg.Wait()

		return *result
	}(arr)

	// show result
	sort.Strings(result)
	for _, s := range result {
		fmt.Println(s)
	}
	fmt.Printf("len(result)=%d\t", len(result))
	fmt.Printf("3**8=%d\n", int(math.Pow(3, 8)))
	fmt.Println("pattern count >>", len(result), "/", int(math.Pow(3, 8)))
}

func main() {
	split("q1")
	q1()
	split("q2")
	q2()
	split("q3")
	q3()
	split("q4")
	q4()
	split("q5")
	q5()
}
