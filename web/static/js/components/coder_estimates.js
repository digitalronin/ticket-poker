import React from "react"

import CoderEstimateHidden from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending from "./coder_estimate_pending"

var CoderEstimates = React.createClass({
  propTypes: {
    estimateComplete: React.PropTypes.bool
  },

  render() {
    var rtn

    // if (this.props.estimateComplete) {
    //   rtn = <CoderEstimateCompleted />
    // } else {
    //   rtn = <CoderEstimateHidden />
    // }
    //
    // return <div className="estimates">{rtn}<hr /></div>

    return(
      <div className="estimates">
        <CoderEstimateHidden />
        <CoderEstimateCompleted />
        <CoderEstimatePending />
        <hr />
      </div>
    )
  }
})

module.exports = CoderEstimates

