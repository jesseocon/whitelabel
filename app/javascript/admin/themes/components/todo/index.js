import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import Root from './root'
import configureStore from './configure-store'
import { fetchTodos } from './api'

const store = configureStore()
export default () => {
  ReactDOM.render(
    <Root store={store} />,
    document.getElementById('editor-app')
  )
}
