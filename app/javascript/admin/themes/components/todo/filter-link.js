import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { setVisibilityFilter } from './actions'
import Link from './link'

const mapStateToProps = (state, ownProps) => {
  return {
    active:
      ownProps.filter ===
      state.visibilityFilter
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    onClick: () => {
      dispatch(setVisibilityFilter(ownProps.filter))
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Link)
