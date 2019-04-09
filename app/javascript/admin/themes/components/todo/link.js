import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { createStore } from 'redux'

const Link = ({
  active,
  onClick,
  children,
}) => {
  if (active) {
    return <span>{children}</span>
  }
  return (
    <a href='#'  onClick={e => {
      e.preventDefault()
      onClick()
    }}>
      {children}
    </a>
  )
}

export default Link
