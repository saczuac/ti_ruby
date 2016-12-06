class TasksController < ApplicationController

  include ListsHelper
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.type = params[:type]
  end

  # GET /tasks/1/edit
  def edit
  end

  # Params handler

  def bind_task_params(task_params)
    priority = Priority.find_by(name: "#{task_params[:priority]}")
    state = State.find_by(name: "#{task_params[:state]}")
    tp = task_params
    tp[:priority] = priority
    tp[:state] = state
    if tp[:type] == 'Simple'
      tp[:since], tp[:until], tp[:percent] = nil 
    elsif tp[:type] == 'Large'
      tp[:since], tp[:until] = nil
    else
      tp[:percent] = nil
    end
    logger.debug "The task parameters are: #{tp.inspect}"
    tp
  end

  # POST /tasks
  # POST /tasks.json
  def create
    tp = bind_task_params(task_params)
    @task = Task.new(tp)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to "/#{search_by_id(task_params[:list])}", notice: 'Task was successfully created.' }
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
    
    respond_to do |format|
      if @task.becomes(Task).update(tp)
        logger.debug 'Entra acá'
        format.html { redirect_to "/#{task_params[:list]}", notice: 'Task was successfully updated.' }
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
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:type, :description, :state, :priority, :list, :until, :since, :percent)
    end
end
