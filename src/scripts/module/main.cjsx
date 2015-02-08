# libs
$ = require 'jQuery'
Annotator = require 'Annotator'
React = require 'react/addons'

# modules
Login = require 'cjsx!./login'
CreateTUA = require 'cjsx!./create-tua'
EditTUA = require 'cjsx!./edit-tua'
TUAItem = require 'cjsx!./tua-item'
TUAItemTextInput = require 'cjsx!./tua-item-text-input'
Buttons = require 'cjsx!./buttons'
Timer = require 'jsx!./example-modules/timer'

Main = React.createClass

  componentDidMount: ->
    $('html').annotator()
             .annotator('setupPlugins');

    # content.annotator 'addPlugin', 'Store',
    #   prefix: '/store/endpoint'
    #   annotationData: 'uri': 'http://this/document/only'
    #   loadFromSearch:
    #     'limit': 20
    #     'uri': 'http://this/document/only'

  render: ->
    <div>
      <Timer/>
      <Login/>
      <EditTUA/>
    </div>

module.exports = Main
