LIVERELOAD_HOST = 'localhost:'
LIVERELOAD_PORT = 35729
connection = new WebSocket('ws://' + LIVERELOAD_HOST + LIVERELOAD_PORT + '/livereload')

connection.onerror = (error) ->
  console.log 'reload connection got error' + JSON.stringify(error)

connection.onmessage = (e) ->
  data = undefined
  data = undefined
  if e.data
    data = JSON.parse(e.data)
    if data and data.command == 'reload'
      chrome.runtime.reload()
