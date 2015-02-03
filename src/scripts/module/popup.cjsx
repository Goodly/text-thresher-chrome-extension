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

Popup = React.createClass

  componentDidMount: ->
    $('html').annotator()

  render: ->
    <div>
      <Timer/>
      <Login/>
      <EditTUA/>
    </div>

module.exports = Popup
