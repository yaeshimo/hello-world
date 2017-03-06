
# Markdown 書式のメモ
markdownの書き方をmarkdownを使いながらメモ  
markdownは実装が確定的ではない  
理解に必要かなと感じたところは実例を  

GFM = github markdown  
escape = \

---
### /\* 見出し \*/
見出しのレベルがいくつまで認識されるかは実装によるため注意
~~~md
# 見出し1　1行の見出し
## 見出し2　1行の見出し、↑の見出しと比べ弱い強調
### 見出し３
#### 見出し4
##### 見出し5
###### 見出し6
####### 見出し7 ...6まで認識
######## 見出し8
######### 見出し9
~~~

---
### /\* 段落分け \*/  
markdownによる文章の段落は空行で表される
~~~md  
段落１  
(空行)  
段落２
~~~
---
### /\* 箇条書き \*/  
~~~md
- １行の文章、箇条書き１
- 同じく、１行の文章、箇条書き２
- 箇条書き３、ハイフンと半角スペース１つで記述
	- 箇条書きのネスト
	- ネスト２
~~~
---
### /\* 番号付きリスト \*/  
markdownに書いた番号は表示と一致しない  
数字なら連番が自動で割り当てられるっぽい
~~~md
1. test
2. next
3. list
 1. nest
4. end  
~~~
##### 表示例
4. test
3. next
2. list
 10. nest
1. end
1. 番号の指定は表示に反映されていない
---
### /\* テキストの強調 \*/  
~~~md
 *強調したいテキスト* **更に強調したいテキスト**  
~~~
---
### /\* 水平線 \*/  
ハイフン3つの連続で直線を表現できる  
3つの連続であるならスペースを含めておｋ
~~~md
---
_ _ _
~~~

---
### /\* 取り消し \*/
~~~md  
~~取り消す文字列~~
~~~
---
### /\* リンク(URL) \*/  
~~~md
[リンクしたい文字] (リンク先URLをこのカッコ内に記述)
~~~
##### リンクの例
リンクラベルがなければクリックできない  
[](https://localhost:80)
[test](https://localhost:80)

##### shcemeを含めた絶対パス
url直でもリンクになるっぽい?  
scheme含めた絶対パスでリンクが認識されるっぽい  
https://localhost
**手元のmd previewではリンク**
**githubでは単にテキスト**

fileはだめっぽい  
file:///home/

---
### /\* URLを段落外へ \*/
リンクの参照を指定できる  
下記の例は実際にリンクは貼られず、リンクの参照の指定のみ行われる
~~~md
[リンクしたい文字2]: https://localhost:80
~~~

---
### /\* 参照リンク \*/  
下記の書き方をすると  
`[リンクラベル1],[リンクラベル2]`は参照先のリンクのアドレスがリンクされる
~~~md
[リンクラベル1][参照先のリンクラベル]  
[リンクラベル2][参照先のリンクラベル]  
文章と段落分け
[参照先のリンクラベル]: リンクのアドレス "リンクタイトル"
~~~
##### 参照の例
やっていることは以下のイメージ  

1. 参照の宣言  
2. 参照へアドレスを代入  
3. 代入した参照を実態と紐付け  


[リンクしたい文字2]  
[リンクしたい文字2]: https://localhost:80  
[test][リンクしたい文字2]  

---
### /\* 同一ページ内リンク \*/  
同一ページのリンクはリンクしたい場所に名前を付けたタグを埋める  
埋めたタグに付けた名前を(#名前)で参照できる  
~~~
[リンクしたい文字列]（#命名された名前）

<a name="命名">リンクしたい場所
~~~
タグは`</a>`が自動で保管されるが、自分で指定してもいい
~~~
<a name="命名">リンクしたい場所</a>
~~~
##### ページ内リンクの例

[ページ内リンクテスト](#locallink)

<a name="locallink">
この場所にリンク
</a>

---
### /\* 引用 \*/  
~~~md
> 引用は、行頭に半角不等号(>)で表される
> スペースを含めるかは未確認  

~~~

---
### /\* 二重引用 \*/  
~~~md
> 引用した文章
>> 引用された文章が引用している文章の表現など、引用のネスト

~~~

---
### /\* code挿入:GFMpre記法 \*/
三連チルダでコードブロックを表現  
~~~c
printf("hello world");
~~~


---
### /\* code挿入:GFMpre記法(バッククォート) \*/  
三連バッククォートでもおｋ
```c
printf("hello world");
```

---
### /\* code:シンタックス \*/  
codeシンタックスはコードブロックの後に指定
対象言語(例:ruby)
~~~ruby
print 'hoge'
~~~

---
### /\* 表組み:GFM \*/  
表の要素は`|`で区切られる  
途中のスペース等はmdをテキストとして表示する時以外は  
表示に影響しない

~~~md
|hedder1|hedder2|hedder3|  
|:------|------:|:-----:|  
|align left|align right|align center|  
|a|b|c|  
~~~
##### 表組み表示例

|hedder1|hedder2|hedder3|  
|:------|------:|:-----:|  
|align left|align right|align center|  
|a|b|c|

---
### /\* ページ内リンク(画像):GFM \*/  
画像のリンクは通常のURLと同様  
`[linkname](URL)`で指定する  
画像の表示なのでlinknameは省略しても問題ないっぽい  
画像をリンクから受けて直接表示したい場合は`!`を使う  
~~~md
[link hackadoll3](./resource/hackadoll3_png_1.png "hackadoll3")  
![link hackadoll3](./resource/hackadoll3_png_1.png "hackadoll3")  
![link hackadoll3](./resource/hackadoll3_gif_1.gif "hackadoll3")  
![link hackadoll3](./resource/hackadoll3_gif_2.gif "hackadoll3")  
![](./resource/hackadoll3_jpg_1.jpg "hackadoll3")  
~~~
##### 表組み表示例  リンクが見つからない場合
[link hackadoll3](./resource/hackadoll3_png_1.png "hackadoll3")  
![](./resource/hackadoll3_jpg_1.jpg "hackadoll3")  
![link hackadoll3](./resource/hackadoll3_png_1.png "hackadoll3")  
![link hackadoll3](./resource/hackadoll3_gif_1.gif "hackadoll3")  
![link hackadoll3](./resource/hackadoll3_gif_2.gif "hackadoll3")  



---
### /\* 改行 \*/  
改行はブラウザが担当する  
強制的に改行を入れたい場合は  
行末にスペースを2つ挿入する  
