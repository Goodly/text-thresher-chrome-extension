import React from 'react/addons';

// Login = require('cjsx!./login');

// Timer = require('jsx!./example-modules/timer');

// ToggleShow = require('cjsx!./toggle-show');

export default React.createClass({
  getInitialState: function() {
    return {
      formDisplayed: true
    };
  },
  componentDidMount: function() {

  },
  onToggleShow: function() {
    return this.setState({
      formDisplayed: !this.state.formDisplayed
    });
  },
  onLaunchLogin: function(state) {
    return console.log(state);
  },
  render: function() {
    if (this.state.formDisplayed){
      let rightPos = '-15px';
    }
    else{
      let rightPos = '-200px';
    }

    let styles = {
      right: rightPos
    };

    <div className="react-module" style={styles}>
      <div>
        <ToggleShow onToggleShow={this.onToggleShow}/>
      </div>
      <div className="module-body">
        <Login onLaunchLogin={this.onLaunchLogin}/>
      </div>
    </div>
  }
});
