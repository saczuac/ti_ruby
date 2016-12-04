class ListsController < ApplicationController

  layout 'list', only: [:new, :index]
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
   # reset_session
    session[:lists] ||= {}
    @list = List.new
    @lists = avaible_lists
  end

  def find(slug) #Returns the name associated to the slug
    session[:lists].each do |key, value|
      if slug == value[1]
        return value[0]
      end 
    end
    nil
  end

  def avaible_lists
    lists = []
    if session[:lists].length > 0
       session[:lists].each do |key, value|
          lists << {name: value[0], url: value[1]}
       end
    end
    lists
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @task = Task.new
    @tasks = Task.where("list = '#{params[:id]}'")
    @tasks ||= []
  end

  # GET /lists/1/edit
  def edit
  end

  def save(name)
   begin
     session[:lists][:"#{session[:lists].length}"] = [name, List.to_slug(name)]
   rescue
     false
   end
    true
  end

  # POST /lists
  # POST /lists.json
  def create
     @list = List.new(list_params[:name])
     logger.debug "New list: #{@list.inspect}"

    respond_to do |format|
      if save(@list.name)
        logger.debug "Avaible lists: #{p session[:lists]}"
        format.html { redirect_to "/#{@list.url}", notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :index }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = find(params[:id])
      @slug = params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.fetch(:list, {})
    end
end
