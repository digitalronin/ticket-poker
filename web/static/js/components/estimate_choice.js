import React from "react"

let EstimateChoice = React.createClass({
  propTypes: {
    coder:    React.PropTypes.string,
    value:    React.PropTypes.number,
    onClick:  React.PropTypes.func
  },

  render() {
    return(
      <div className="estimate-card estimate-choice blue-grey valign-wrapper" onClick={this.handleClick}>
        <p>{this.props.value}</p>
      </div>
    )
  },

  handleClick() {
    this.props.onClick(this.props.coder, this.props.value)
  }
})

module.exports = EstimateChoice

