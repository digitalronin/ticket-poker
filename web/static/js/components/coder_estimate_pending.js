import React from "react"

import EstimateChoice from "./estimate_choice"

// TODO: pass in coder and point options

var CoderEstimatePending = React.createClass({
  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-pending">
          <span className="coder">Jesus</span>
        </div>

        <EstimateChoice coder="Jesus" value={1} />
        <EstimateChoice coder="Jesus" value={2} />
        <EstimateChoice coder="Jesus" value={3} />
        <EstimateChoice coder="Jesus" value={5} />
        <EstimateChoice coder="Jesus" value={8} />
        <EstimateChoice coder="Jesus" value={13} />
      </div>
    )
  }
})

module.exports = CoderEstimatePending

