class Task < ApplicationRecord
  enum priority:{high: 0, low: 1}
  enum status:{wating: 0, working: 1, done: 2, complete: 3}
end
