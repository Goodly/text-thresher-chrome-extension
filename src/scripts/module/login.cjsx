React = require 'react/addons'
Button = require 'react-bootstrap/Button'
Panel = require 'react-bootstrap/Panel'

Login = React.createClass

  getInitialState: ->
    inputs:
      username: ''
      publickey: ''

  launchLogin: ->
    @props.onLaunchLogin(@state)

  handleChange: ->
    @setState
      inputs:
        username: @refs.username.getDOMNode().value
        publickey: @refs.publickey.getDOMNode().value
    console.log @state.inputs

  render: (inputs) ->
    username = @state.inputs.username
    publickey = @state.inputs.publickey
    <Panel bsStyle="primary" className="login-panel">
      <input type="text" ref="username" className="login-inputs" value={username} onChange={@handleChange} placeholder="username"/>
      <input type="text"  ref="publickey" className="login-inputs" value={publickey} onChange={@handleChange} placeholder="public key"/>
      <Button bsStyle="primary" className="login-button" onClick={@launchLogin}>Login</Button>
    </Panel>

module.exports = Login

