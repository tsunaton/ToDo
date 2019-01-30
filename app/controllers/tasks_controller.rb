class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy, :show]

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, success: "success"
    else
      flash.now[:danger] = "faild"
      render :new
    end
  end

  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to @task, success: "success"
    else
      flash.now[:danger] = "faild"
      render :edit
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
    redirect_to tasks_path
    end
  end

  def start
    task = Task.find(params[:id])
    task.start_date = Date.today

    if task.save
      task.working!
      redirect_to tasks_path
    else
      flash.now[:danger] = "saving faild"
      render :index
    end
  end

  def sort
    if params[:sort_id] == "0"
      @tasks = Task.priority_sort
    elsif params[:sort_id] == "1"
      @tasks = Task.scheduled_finish_date_sort
    elsif params[:sort_id] == "2"
      @tasks = Task.start_date_sort
    elsif params[:sort_id] == "3"
      @tasks = Task.end_date_sort
    elsif params[:sort_id] == "4"
      @tasks = Task.title_sort
    elsif params[:sort_id] == "5"
      @tasks = Task.status_sort
    end

    render :index
  end

  def end
    task = Task.find(params[:id])
    task.end_date = Date.today

    if task.save
      task.done!
      redirect_to tasks_path
    else
      flash.now[:danger] = "saving faild"
      render :index
    end
  end

  # def search
  #   if params[:priority].empty?&&params[:status].empty?
  #     @tasks = Task.title_search(params[:search_words])
  #   elsif params[:priority].empty?
  #     @tasks = Task.title_search(params[:search_words]).status_search(params[:status])
  #   elsif params[:status].empty?
  #     @tasks = Task.title_search(params[:search_words]).priority_search(params[:priority])
  #   else
  #     @tasks = Task.title_search(params[:search_words]).priority_search(params[:priority]).status_search(params[:status])
  #   end
  #   render :index
  # end

  def search
    @task = Search::Task.new(search_params)
    @tasks = @task
      .matches
      # .order(availability: :desc, code: :asc)
      # .decorate
    render :index
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :scheduled_finish_date, :priority)
    end

    def search_params
      params.require(:task).permit(Search::Task::ATTRIBUTES)
    end

end
