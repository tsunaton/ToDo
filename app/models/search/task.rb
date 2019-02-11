class Search::Task < Search::Base
  ATTRIBUTES = %i(
    search_words
    priority
    status
    start_date
    scheduled_finish_date
      )


  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Task.arel_table
    results = ::Task.all
    results = results.where(contains(t[:title], search_words)) if search_words.present?
    results = results.where(contains(t[:priority], priority)) if priority.present?
    results = results.where(contains(t[:status], status)) if status.present?
    results
  end
end
