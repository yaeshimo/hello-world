let main = {
  add: function(x,y) {
    if (typeof x === 'number' && typeof y === 'number') {
      return x+y;
    }
    throw "add(): argument is not number";
  }
};

module.exports = main;
