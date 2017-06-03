const http = require("http");
const port = 3000;
http.createServer(function (request, response) {
  response.writeHead(200, {'Content-Type': 'text/plain'});
  response.end('FROM [hello.js]: hello world\n');
}).listen(port);
console.log('Server run port:' +port);
