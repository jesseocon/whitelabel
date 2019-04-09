import React, { Component } from 'react'
import { connect } from 'react-redux'
import TodoList from './todo-list'
import { getVisibleTodos } from './reducers'
import * as actions from './actions'
import { fetchTodos } from './api'
//import { toggleTodo, receiveTodos } from './actions'

class VisibleTodoList extends Component {
  componentDidMount () {
    this.fetchData()
  }

  componentDidUpdate (prevProps) {
    if (this.props.filter !== prevProps.filter) {
      this.fetchData()
    }
  }

  fetchData () {
    const { filter, fetchTodos } = this.props
    fetchTodos(filter).then((todos) => {
      fetchTodos(filter, todos)
    })
  }

  render () {
    return <TodoList {...this.props} />
  }
}

const mapStateToProps = (state) => {
  const filter = state.visibilityFilter
  return {
    filter,
    todos: getVisibleTodos(
      state,
      state.visibilityFilter,
    )
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onTodoClick: (id) => {
      dispatch(actions.toggleTodo(id))
    },
    fetchTodos: (filter, response) => {
      dispatch(fetchTodos(filter, response))
    }
  }
}

VisibleTodoList = connect(
  mapStateToProps, mapDispatchToProps
)(VisibleTodoList)

export default VisibleTodoList
