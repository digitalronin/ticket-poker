import React from "react"

var CoderEstimateHidden = React.createClass({
  propTypes: {
    coder: React.PropTypes.string,
  },

  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-hidden" onClick={this.handleClick}>
          <span className="coder">{this.props.coder}</span>: ?
        </div>
      </div>
    )
  },

  handleClick() {
    console.log(`${this.props.coder} wants to change their hidden estimate`)
  }

})

module.exports = CoderEstimateHidden

