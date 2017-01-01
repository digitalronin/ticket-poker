import React from "react"

let CoderEstimateHidden = React.createClass({
  propTypes: {
    coder:    React.PropTypes.string,
    onClick:  React.PropTypes.func
  },

  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-hidden" onClick={this.handleClick}>
          <div className="coder">{this.props.coder}</div>
          <div className="estimate-value blue-grey-text">
           ?
          </div>
        </div>
      </div>
    )
  },

  handleClick() {
    this.props.onClick(this.props.coder, 0)
  }

})

module.exports = CoderEstimateHidden

