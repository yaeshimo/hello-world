let main = require('./main.js');

function assert(i, exp, out) {
  console.log("error case: [" + i + "]");
  console.assert(exp === out, "\nexp: " + exp, "\nout: " + out);
}

function Testadd() {
  console.log("- Testadd");
  let caseCounter = 0;
  //for{};
  assert(caseCounter, 0, main.add(1,1));
}

Testadd();
