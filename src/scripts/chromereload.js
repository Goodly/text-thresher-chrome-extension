var LIVERELOAD_HOST, LIVERELOAD_PORT, connection;

LIVERELOAD_HOST = void 0;

LIVERELOAD_PORT = void 0;

connection = void 0;

LIVERELOAD_HOST = "localhost:";

LIVERELOAD_PORT = 35729;

connection = new WebSocket("ws://" + LIVERELOAD_HOST + LIVERELOAD_PORT + "/livereload");

connection.onerror = function(error) {
  console.log("reload connection got error" + JSON.stringify(error));
};

connection.onmessage = function(e) {
  var data;
  data = void 0;
  if (e.data) {
    data = JSON.parse(e.data);
    if (data && data.command === "reload") {
      chrome.runtime.reload();
    }
  }
};
