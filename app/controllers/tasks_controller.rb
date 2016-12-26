class TasksController < ApplicationController

  include ListsHelper
  include TasksHelper

  before_action :set_task, only: [:show, :edit, :update, :destroy]


  # GET /tasks
  # GET /tasks.json
  def index
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.type = params[:type]
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    tp = bind_task_params(task_params)
    @task = Task.new(tp)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to "/#{tp[:list].slug}", notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    tp = bind_task_params(task_params)
    task_class = Object.const_get "#{tp[:type]}"
    respond_to do |format|
      if @task.becomes(task_class).update(tp)
        format.html { redirect_to "/#{tp[:list].slug}", notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    render :file => "#{Rails.root}/public/404.html",  :status => 404
    #@task.destroy
    #respond_to do |format|
    #  format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:type, :description, :state, :priority, :list, :until, :since, :percent)
    end
end
