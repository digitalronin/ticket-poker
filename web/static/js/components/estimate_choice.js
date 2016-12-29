import React from "react"

var EstimateChoice = React.createClass({
  propTypes: {
    coder:    React.PropTypes.string,
    value:    React.PropTypes.number,
    onClick:  React.PropTypes.func
  },

  render() {
    return(
      <div className="estimate-card estimate-choice" onClick={this.handleClick}>
        {this.props.value}
      </div>
    )
  },

  handleClick() {
    this.props.onClick(this.props.coder, this.props.value)
  }
})

module.exports = EstimateChoice

