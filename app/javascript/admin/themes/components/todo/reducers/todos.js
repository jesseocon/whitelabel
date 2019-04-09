import { combineReducers } from 'redux'
import todo from './todo'

const byId = (state = {}, action) => {
  switch (action.type) {
    case 'ADD_TODO':
    case 'TOGGLE_TODO':
      return {
        ...state,
        [action.id]: todo(state[action.id], action)
      }
    default:
      return state
  }
}

const allIds = (state = [], action) => {
  switch (action.type) {
    case 'ADD_TODO':
      return [...state, action.id]
    default:
      return state
  }
}

const todos = combineReducers({
  byId,
  allIds,
})

const getAllTodos = (state) => {
  return state.allIds.map(id => state.byId[id])
}
/* this is a selector method **/
export const getVisibleTodos = (
  state,
  filter
) => {
  const allTodos = getAllTodos(state)
  switch(filter) {
    case 'SHOW_ALL':
      return allTodos
    case 'SHOW_COMPLETED':
      return allTodos.filter(
        t => t.completed
      )
    case 'SHOW_ACTIVE':
      return allTodos.filter(
        t => !t.completed
      )
    default:
      return state
  }
}

export default todos
