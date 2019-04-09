import { combineReducers } from 'redux'
import todos, * as fromTodos from './todos'
import visibilityFilter from './visibility-filter'

const todoApp = combineReducers({
  todos,
  visibilityFilter,
})

export const getVisibleTodos = (state, filter) => {
  return fromTodos.getVisibleTodos(state.todos, filter)
}

export default todoApp
