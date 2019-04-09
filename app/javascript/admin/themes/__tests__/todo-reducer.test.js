import todos from '../todo-reducer'
import { getVisibleTodos } from '../todo-reducer'

test('reducer should add todos', () => {
  const stateBefore = {}
  const newTodo = { type: 'ADD_TODO', id: 1, text: 'learn redux' }
  const stateAfter = {
    "todos": [
      {
        "completed": false,
        "id": 1, "text":
        "learn redux",
      }
    ],
    "visibilityFilter": "SHOW_ALL",
  }

  expect(
    todos({}, newTodo)
  ).toEqual(stateAfter)
})

test('reducer should toggle todos', () => {
  const stateBefore = {
    "todos": [
      {
        "completed": false,
        "id": 1, "text":
        "learn redux",
      }
    ],
    "visibilityFilter": "SHOW_ALL",
  }

  const stateAfter = {
    "todos": [
      {
        "completed": true,
        "id": 1, "text":
        "learn redux",
      }
    ],
    "visibilityFilter": "SHOW_ALL",
  }
  const toggleAction = { type: 'TOGGLE_TODO', id: 1 }
  expect(todos(stateBefore, toggleAction)).toEqual(stateAfter)
})

test('#getVisibleTodos to filter todos', () => {
  const completedTodo = { id: 1, text: 'text', completed: true }
  const incompleteTodo = { id: 2, text: 'incomplete', completed: false }
  const todos = [completedTodo, incompleteTodo]
  const beforeState = {
    ...todos,
    'visibilityFilter': 'SHOW_ALL'
  }
  const completedState = {
    ...todos,
    visibilityFilter: 'SHOW_COMPLETED'
  }

  const activeState = {
    ...todos,
    visibilityFilter: 'SHOW_ACTIVE'
  }
  expect(getVisibleTodos(todos, 'SHOW_ALL')).toEqual(todos)
  expect(getVisibleTodos(todos, 'SHOW_COMPLETED')).toEqual([completedTodo])
  expect(getVisibleTodos(todos, 'SHOW_ACTIVE')).toEqual([incompleteTodo])
})
