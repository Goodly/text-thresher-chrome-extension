chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.executeScript null, file: 'dist/scripts/domcontent.js'
  chrome.tabs.executeScript null, file: 'dist/scripts/moduleBundle.js'
