import { v4 } from 'uuid'

const fakeDatabase = {
  todos: [
    {
      id: v4(),
      text: 'hey',
      completed: true,
    },
    {
      id: v4(),
      text: 'ho',
      completed: false,
    },
    {
      id: v4(),
      text: "let's go!",
      completed: false,
    },
    {
      id: v4(),
      text: 'yeah yeah.',
      completed: false,
    },
  ]
}

const delay = (ms) =>
  new Promise(resolve => setTimeout(resolve, ms))

export const fetchTodos = (filter) =>
  delay(500).then(() => {
    switch (filter) {
      case 'SHOW_ALL':
        return fakeDatabase.todos
      case 'SHOW_ACTIVE':
        return fakeDatabase.todos.filter(t => !t.completed)
      case 'SHOW_COMPLETED':
        return fakeDatabase.todos.filter(t => t.completed)
      default:
        throw new Error(`Unknown filter: ${filter}`)
    }
  })
