import React from "react"

var EstimateChoice = React.createClass({
  propTypes: {
    coder: React.PropTypes.string,
    value: React.PropTypes.number
  },

  render() {
    return(
      <div className="estimate-card estimate-choice" onClick={this.handleClick}>
        {this.props.value}
      </div>
    )
  },

  handleClick() {
    console.log(`${this.props.coder} estimates ${this.props.value}`)
  }
})

module.exports = EstimateChoice

