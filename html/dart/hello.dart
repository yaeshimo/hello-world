// dart2js -o [outname] hello.dart
// >> dart2js -o ./dart2js/fromdart.js ./hello.dart
// or
// dartdevc -o [outname] hello.dart
// >> dartdevc -o ./dartdevc/fromdart.js ./hello.dart

// NOTE: dartdevc は期待した結果にならなかった
//     : 何か間違えてる? 開発版だから?

import 'dart:html';

void main() {
  querySelector("#helloDart").text = "hello dart!!";
}
