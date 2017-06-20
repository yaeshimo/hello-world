g1 = 1; // global
var v1 = 10; // function scope
let l1 = 100; // block scope

console.log("definition: ", g1, v1, l1);
console.log();

function func() {
  g2 = 2;
  var v2 = 20;
  let l2 = 200;
  console.log("in function: ", g1, v1, l1);
  console.log("in function: ", g2, v2, l2);
  console.log();

  {
    let l2 = 200*2;// new
    console.log("scope1:", g2, v2, l2);
    console.log("l2*2: ", l2);// 400

  }
  console.log("exit scope2 l2: ", l2);// 200
  console.log();

  {
    var v2 = 20*2;
    console.log("scope2:", g2, v2, l2);
    console.log("v2*2: ", v2);
  }
  console.log("exit scope2 v2: ", v2);
  console.log();

}
func();

console.log("after function g2: ", g2);
console.log();

try {
  console.log(v2, l2); // definition error
}
catch (e) {
  console.error("CATCH ERROR:\n", e);
}
