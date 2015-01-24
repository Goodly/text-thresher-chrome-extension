require 'script!jquery/dist/jquery'
require 'script!annotator/annotator-full.min'

# console.log window.location.host
# console.log window.Annotator

# $(document.body).annotator()
# ann.setupPlugins()

$(document).on 'click', (e) ->
  if !($(e.target).parents('.annotator-widget').length)
    # $(e.target).annotator().annotator('addPlugin', 'Tags')
    annotator = new Annotator(e.target)
  else
    console.log 'im an annotator-widget'

# chrome.runtime.sendMessage
#     'title': document.title
#     'url': window.location.href
#     'summary': window.getSelection().toString()
