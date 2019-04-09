import { sum } from './add'

test('adds 1 + 2 and equals 3', () => {
  expect(sum(1, 2))
    .toBe(3)
})
