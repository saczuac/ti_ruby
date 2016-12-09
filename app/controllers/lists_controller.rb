class ListsController < ApplicationController
  
  include ListsHelper
  include TasksHelper

  layout 'list', only: [:new, :index]
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /
  # GET /lists
  # GET /lists.json
  def index
   # reset_session # uncomment the first hashtag if you want to reset the session
    session[:lists] ||= {}
    session[:lists][:"0"] = ['Lista 0', to_slug('Lista 0'), Time.now, Time.now]
    @list = List.new
    @lists = avaible_lists.last(5)
  end

  # GET /:id
  # GET /lists/1
  # GET /lists/1.json
  def show
    if is_in_lists?(params[:id])
      @task = Task.new
      @tasks = Task.where("list = '#{search(params[:id])}'")
      @tasks, expireds = @tasks.partition {|t| t.until >= Date.today rescue t }
      set_expired_state(expireds)
      @tasks = @tasks.sort_by { |t| t.priority_id }
      @last_update = last_updated_task(@tasks).updated_at > last_update_of_list(params[:id]) ? last_updated_task(@tasks).updated_at : last_update_of_list(params[:id]) rescue last_update_of_list(params[:id]) 
      @created_at = date_of_created(params[:id])
      @tasks ||= []
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  # GET /lists/:slug/edit
  def edit
  end

  # POST /
  # POST /lists
  # POST /lists.json
  def create
    respond_to do |format|
      @list = List.new(list_params[:name], to_slug(list_params[:name]))

      if save(@list.name)
        format.html { redirect_to "/#{@list.url}", notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { redirect_to "/", notice: "Error: The slug #{to_slug(list_params[:name])} already exists." }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST '/lists/:slug/edit'
  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    old_name = find_name_by_slug(params[:slug])
    new_name = params[:"#{old_name}"][:name]

    respond_to do |format|
        list_update(new_name, old_name)
        format.html { redirect_to "/#{params[:slug]}", notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_list
      @slug_name = params[:id] 
      @list = find_name_by_slug(params[:id])
      @slug = search(params[:id])
    end

    def list_params
      params.fetch(:list, {})
    end
end
