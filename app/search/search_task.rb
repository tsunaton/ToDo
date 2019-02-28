class SearchTask
  # ATTRIBUTES = %i(
  #   search_words
  #   priority
  #   status
  #   start_date
  #     )
  # attr_accessor(*ATTRIBUTES)

  def initialize(title = nil,
                priority = nil,
                status = nil,
                start_date = nil )
    @title = title
    @priority = priority
    @status =  status
    @start_date = start_date
  end

  def matches
    results = Task.all
    results = results.where("title LIKE ?", "%#{@title}%") if @title.present?
    results = results.where(priority: @priority) if @priority.present?
    results = results.where(status: @status) if @status.present?
    results = results.where(start_date: @start_date.to_date ) if @start_date.present?
    return results
  end
end
