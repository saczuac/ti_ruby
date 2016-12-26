class ListsController < ApplicationController
  
  include ListsHelper
  include TasksHelper

  layout 'list', only: [:new, :index]
  before_action :set_list, only: [:show, :edit]

  # GET /
  # GET /lists
  # GET /lists.json
  def index
    #reset_session # uncomment the first hashtag if you want to reset the session
    session[:lists] ||= {}
    @list = List.new
    @lists = avaible_lists.last(5)
  end

  # GET /:id
  # GET /lists/1
  # GET /lists/1.json
  def show
    l = List.find_by(slug: params[:id])
    unless l.nil?
      @task = Task.new
      @tasks = l.tasks.order(:priority_id) || []
      @last_update = last_updated_task(@tasks).updated_at > l.updated_at ? last_updated_task(@tasks).updated_at : l.updated_at rescue l.updated_at 
      @created_at = l.created_at
      @test = @tasks.map {|t| t.description }
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  # GET /lists/:slug/edit
  def edit
  end

  def to_slug(name)
      unless name.nil?
        #strip the string
        ret = name.strip.downcase
        #blow away apostrophes
        ret.gsub! /['`]/,""
        # @ --> at, and & --> and
        ret.gsub! /\s*@\s*/, " at "
        ret.gsub! /\s*&\s*/, " and "
        #replace all non alphanumeric, underscore or periods with underscore
        ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  
        #convert double underscores to single
        ret.gsub! /-+/,"-"
        #strip off leading/trailing underscore
        ret.gsub! /\A[-\.]+|[-\.]+\z/,""
        ret
      end
  end

  # POST /
  # POST /lists
  # POST /lists.json
  def create
    @list = List.new({ title: params[:list][:title], slug: to_slug(params[:list][:title])})
    respond_to do |format|
      if @list.save
        add_list_to_session(@list.slug)
        format.html { redirect_to "/#{@list.slug}", notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { redirect_to "/", notice: "Error: The slug #{to_slug(params[:list][:title])} already exists or it is invalid" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST '/lists/:slug/edit'
  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    @list = List.find_by(slug: params[:slug])
    old_name = @list.title
    new_name = params[:"#{old_name}"][:title]

    respond_to do |format|
      if new_name.length != 0 && @list.update({title: new_name})
        format.html { redirect_to "/#{params[:slug]}", notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { redirect_to "/lists/#{params[:slug]}/edit", notice: "Error: You must enter a new name" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
     end
  end

  private
  
    def set_list
      @slug_name = params[:id] 
      @list = List.find_by(slug: params[:id]).title
      @slug = List.find_by(slug: params[:id]).id
    end

    def task_params
      params.require(:list).permit(:slug, :title)
    end
end
