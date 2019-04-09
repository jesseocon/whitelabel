import React from 'react'
import PropTypes from 'prop-types'
import AddTodo from './add-todo'
import VisibleTodoList from './visible-todo-list'
import Footer from './footer'

const TodoApp = () => {
  return (
    <div>
      <AddTodo/>
      <VisibleTodoList/>
      <Footer/>
    </div>
  )
}
TodoApp.contextTypes = {
  store: PropTypes.object,
}

export default TodoApp
