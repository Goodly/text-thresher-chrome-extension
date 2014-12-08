React = require 'react/addons'
Button = require 'react-bootstrap/Button'
Glyphicon = require 'react-bootstrap/Glyphicon'


EditTUA = React.createClass

  render: ->
    <div>
      <Button title= "Edit"><Glyphicon glyph= "pencil" /></Button>
      <p>Edits</p>
    </div>

module.exports = EditTUA
