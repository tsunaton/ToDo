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

  def search
    unless params[:start_date].nil?
      @task.start_date = Time.zone.local(params["start_date(1i)"].to_i, params["start_date(2i)"].to_i, params["start_date(3i)"].to_i)
    end
    @task = SearchTask.new(params[:search_words], params[:priority], params[:status])
    @tasks = @task.matches
    respond_to do |format|
      format.html
      format.js {render 'index', tasks: @tasks}
    end
  end

  private

    def task_params
      params.require(:task)
            .permit(:title, :description, :scheduled_finish_date, :priority)
    end

end
