import { v4 } from 'uuid'
import * as api from '../api'

export const receiveTodos = (filter, response) => ({
  filter,
  response,
  type: 'RECEIVE_TODOS',
})

// export const fetchTodos = (filter) => {
//   return api.fetchTodos(filter).then(response => {
//     receiveTodos(filter, response)
//   }
// }

export const fetchTodos = (filter) => {
  api.fetchTodos(filter).then((response) => {
    receiveTodos(filter, response)
  })
}

export const addTodo = (text) => {
  return {
    text,
    type: 'ADD_TODO',
    id: v4(),
  }
}

export const setVisibilityFilter = (filter) => {
  return {
    filter,
    type: 'SET_VISIBILITY_FILTER',
  }
}

export const toggleTodo = (id) => {
  return {
    id,
    type: 'TOGGLE_TODO',
  }
}
