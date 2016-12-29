import React from "react"

var CoderEstimateHidden = React.createClass({
  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-hidden" onClick={this.handleClick}>
          <span className="coder">David</span>: ?
        </div>
      </div>
    )
  },

  handleClick() {
    console.log('CoderEstimateHidden change my estimate')
  }

})

module.exports = CoderEstimateHidden

