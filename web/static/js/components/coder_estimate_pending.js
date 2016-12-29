import React from "react"

import EstimateChoice from "./estimate_choice"

// TODO: pass in coder and point options

var CoderEstimatePending = React.createClass({
  propTypes: {
    coder: React.PropTypes.string,
    pointOptions: React.PropTypes.array
  },

  render() {
    var choices = this.props.pointOptions.map((p) => { return <EstimateChoice coder={this.props.coder} key={p} value={p} /> })

    return(
      <div className="estimate">
        <div className="estimate-card estimate-pending">
          <span className="coder">{this.props.coder}</span>
        </div>
        {choices}
      </div>
    )
  }
})

module.exports = CoderEstimatePending

