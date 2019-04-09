import counter from '../theme-reducer'

test('increments correctly', () => {
  expect(counter(0, { type: 'INCREMENT' })).toEqual(1)
})

test('decrements correctly', () => {
  expect(counter(1, { type: 'DECREMENT' })).toEqual(0)
})
