var addBookmark, onPageDetailsReceived, statusDisplay;

onPageDetailsReceived = function(pageDetails) {
  document.getElementById("title").value = pageDetails.title;
  document.getElementById("url").value = pageDetails.url;
  document.getElementById("summary").innerText = pageDetails.summary;
};

addBookmark = function() {
  var params, postUrl, summary, tags, title, url, xhr;
  event.preventDefault();
  postUrl = "http://post-test.local.com";
  xhr = new XMLHttpRequest();
  xhr.open("POST", postUrl, true);
  title = encodeURIComponent(document.getElementById("title").value);
  url = encodeURIComponent(document.getElementById("url").value);
  summary = encodeURIComponent(document.getElementById("summary").value);
  tags = encodeURIComponent(document.getElementById("tags").value);
  params = "title=" + title + "&url=" + url + "&summary=" + summary + "&tags=" + tags;
  params = params.replace(/%20/g, "+");
  xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4) {
      statusDisplay.innerHTML = "";
      if (xhr.status === 200) {
        statusDisplay.innerHTML = "Saved!";
        window.setTimeout(window.close, 1000);
      } else {
        statusDisplay.innerHTML = "Error saving: " + xhr.statusText;
      }
    }
  };
  xhr.send(params);
  statusDisplay.innerHTML = "Saving...";
};

statusDisplay = null;

window.addEventListener("load", function(evt) {
  statusDisplay = document.getElementById("status-display");
  document.getElementById("addbookmark").addEventListener("submit", addBookmark);
  chrome.runtime.getBackgroundPage(function(eventPage) {
    eventPage.getPageDetails(onPageDetailsReceived);
  });
});
