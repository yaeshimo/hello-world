let main = require('./main.js');

function assert(i, exp, out) {
  console.log("error case: [" + i + "]");
  console.assert(exp === out, "\nexp: " + exp, "\nout: " + out);
}

function Testadd() {
  console.log("- Testadd");

  //type input struct { arg1, arg2 int}
  //tests := []struct{ exp int, in input}{{exp: 0, in: input{ arg1:1, arg2:2}},}
  //for i, v := range tests {
  //  assert(i, v.exp, main.add(v.in1,v.in2))
  //}

  let caseCounter = 0;
  assert(caseCounter, 0, main.add(1,1));// expected 0 but 2
}

Testadd();
