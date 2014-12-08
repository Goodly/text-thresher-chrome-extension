console.log ('fresh');
var getPageDetails;

getPageDetails = function(callback) {
  chrome.tabs.executeScript(null, {
    file: "dist/scripts/contentScript.js"
  });
  chrome.runtime.onMessage.addListener(function(message) {
    console.log(message);
    callback(message);
  });
};
