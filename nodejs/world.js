const net = require('net');
const port = 3000;
const host = 'localhost';
// echo server
const server = net.createServer(function (stream) {
  console.log('server connected');
  stream.setTimeout(1000*30);
  stream.on('end', function() {
    console.log('server disconnected');
  });
  stream.on('data', function (data) {
    stream.write(data);
  });
  stream.on('timeout', function() {
    console.log('server connection timeout');
    stream.destroy();
  })
  stream.on('error', function(e) {
    console.log('stream error:');
    console.error(e.stack);
    server.close();
    console.log('server closed');
  });
});

console.log('listen addr:'+port);
server.listen(port, host);
