class Task < ApplicationRecord
  enum priority:{high: 0, low: 1}
  enum status:{wating: 0, working: 1, done: 2}

  belongs_to :user

  scope :priority_sort, -> { order(priority: :asc) }
  scope :title_sort, -> { order(title: :asc) }
  scope :start_date_sort, -> { order(start_date: :desc) }
  scope :end_date_sort, -> { order(end_date: :asc) }
  scope :status_sort, -> { order(status: :asc) }
  scope :scheduled_finish_date_sort, -> { order(scheduled_finish_date: :asc) }

  scope :title_search, -> (search_words){ where("title LIKE ?", "%#{search_words}%") }
  scope :priority_search, -> (value){ where(priority: value) }
  scope :status_search, -> (value){ where(status: value) }
  # def self.search2(searched, search_words)
  #   Task.where(["#{searched} LIKE ?", "%#{search_words}%"])
  # end

end
