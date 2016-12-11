require "rails_helper"

RSpec.describe ListsController, :type => :controller do
  describe "POST #index" do
    it "should redirect to index because there is not name" do
      get :index
      post :create, {:list => {:name => nil}}
      expect(response).to redirect_to("/")
    end

    it "should be redirect to /slug " do
      get :index
      post :create, {:list => {:name => 'alta lista aca'}}
      expect(response).to redirect_to("/alta-lista-aca")
    end

    it "should be redirect to index because the slug it is already taken" do
      get :index
      controller.session[:lists] = {}
      controller.session[:lists][:"1"] = ['lista que se repite', 'lista-que-se-repite', Time.now, Time.now]
      post :create, {:list => {:name => 'lista que se repite'}}
      expect(response).to redirect_to("/")
    end
  end

  describe "Order of tasks" do
  
    it "should be ordered" do 
      controller.session[:lists] = {}
      controller.session[:lists][:"0"] = ['lista nueva', 'lista-nueva', Time.now, Time.now]
      
      State.create([{name:'Pending'},{name:'Finished'},{name:'In progress'},{name:'Expired'}])
      Priority.create([{name:'High'}, {name:'Medium'}, {name:'Low'}])
      p = State.find_by(name:'Pending')
      f = State.find_by(name:'Finished')
      ip = State.find_by(name:'In progress')
      h = Priority.find_by(name:'High')
      m = Priority.find_by(name:'Medium')
      l = Priority.find_by(name:'Low')

      Task.create([
        {type:'Large', description:'Hola tarea larga acá', list:'0', state:p, priority:l, percent:50},
        {type:'Simple', description:'Hola tarea simple', list:'0', state:p, priority:m},
        {type:'Temporary', description:'Terminar trabajo final de ruby', list:'0', state:p, priority:h, since: Time.now, until: DateTime.new(2017,12,25) },
      ])
      
      get :show, {id:'lista-nueva'}

      expect(assigns(:test)).to match_array(['Terminar trabajo final de ruby','Hola tarea simple', 'Hola tarea larga acá'])

    end
  
  end

  describe "when the until day is in the past" do

    it "should change the state to expired" do
      controller.session[:lists] = {}
      controller.session[:lists][:"1"] = ['lista dos', 'lista-dos', Time.now, Time.now]
      State.create([{name:'Pending'},{name:'Finished'},{name:'In progress'},{name:'Expired'}])
      Priority.create([{name:'High'}, {name:'Medium'}, {name:'Low'}])
      p = State.find_by(name:'Pending')
      f = State.find_by(name:'Finished')
      ip = State.find_by(name:'In progress')
      h = Priority.find_by(name:'High')
      m = Priority.find_by(name:'Medium')
      l = Priority.find_by(name:'Low')

      t = Task.create({type:'Temporary', description:'Prueba', list:'1', state:p, priority:h, since: DateTime.new(2016,11,25), until: DateTime.new(2016,12,5)})
      get :show, {id:'lista-dos'}

      expect(assigns(:expireds)).to eq([t])
    end
 end

end
