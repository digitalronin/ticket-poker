import React from "react"

var CoderEstimateHidden = React.createClass({
  propTypes: {
    coder:    React.PropTypes.string,
    onClick:  React.PropTypes.func
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
    this.props.onClick(this.props.coder, 0)
  }

})

module.exports = CoderEstimateHidden

