import React from "react"

import CoderEstimateHidden    from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending   from "./coder_estimate_pending"

let Ticket = React.createClass({
  propTypes: {
    channel:   React.PropTypes.object,
    ticketId:  React.PropTypes.string
  },

  getInitialState() {
    return {
      pointOptions:  [],
      estimates:     {}
    }
  },

  componentDidMount() {
    this.props.channel.on("update", (payload) => {
      this.setState({
        estimates:     payload.estimates,
        pointOptions:  payload.point_options
      })
    })

    this.props.channel.push('get_ticket', { ticket_id: this.props.ticketId })
  },

  render() {
    let estimateComplete = this.isEstimateComplete(this.state.estimates)

    let estimateRows = Object.keys(this.state.estimates).sort().map((key) => {
      return this.estimateRow(estimateComplete, key, this.state.estimates[key])
    })

    let heading = (estimateComplete)
                  ? <div><h2>Estimation complete</h2></div>
                  : <div>
                      <h2>Estimation pending</h2>
                      <p>
                        Estimates are hidden until all team members have estimated
                      </p>
                    </div>

    return(
      <div>
        {heading}
        <p>
          Click the cards to choose/change <b>your</b> estimate
        </p>
        <div className="estimates">
          {estimateRows}
        </div>
      </div>
    )
  },

  estimatesRemaining(estimates) {
    let values = Object.keys(estimates).map((key) => { return estimates[key] })
    return values.filter((i) => { return i === 0 }).length
  },

  isEstimateComplete(estimates) {
    return this.estimatesRemaining(estimates) === 0
  },

  estimateRow(estimateComplete, coder, points) {
    var rtn

    if (points === 0) {
      rtn = <CoderEstimatePending key={coder}
                                  coder={coder}
                                  pointOptions={this.state.pointOptions}
                                  onEstimate={this.updateEstimate} />
    } else {
      rtn = (estimateComplete)
            ? <CoderEstimateCompleted key={coder}
                                      coder={coder}
                                      points={points}
                                      onClick={this.updateEstimate} />
            : <CoderEstimateHidden key={coder}
                                   coder={coder}
                                   onClick={this.updateEstimate} />
    }

    return rtn
  },


  updateEstimate(coder, points) {
    this.props.channel.push('update', {
      ticket_id:  this.props.ticketId,
      coder:      coder,
      points:     points
    })
  },

  updateStateFromServerData(payload) {
    this.setState({
      estimates:     payload.estimates,
      pointOptions:  payload.point_options
    })
  }

})

module.exports = Ticket
