import React from "react"

import CoderEstimateHidden from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending from "./coder_estimate_pending"

// TODO: pass in the state as estimates hash and pointOptions array

var CoderEstimates = React.createClass({
  propTypes: {
    estimateComplete: React.PropTypes.bool
  },

  render() {
    // var rtn
    //
    // if (this.props.estimateComplete) {
    //   rtn = <CoderEstimateCompleted />
    // } else {
    //   rtn = <CoderEstimateHidden />
    // }
    //
    // return <div className="estimates">{rtn}<hr /></div>

    var pointOptions = [1, 2, 3, 4, 5]

    return(
      <div className="estimates">
        <CoderEstimateHidden />
        <CoderEstimateCompleted />
        <CoderEstimatePending coder="Jesus" pointOptions={pointOptions} />
        <hr />
      </div>
    )
  }
})

module.exports = CoderEstimates

