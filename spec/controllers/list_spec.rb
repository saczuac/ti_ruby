require "rails_helper"

RSpec.describe ListsController, :type => :controller do
  describe "POST #index" do
    it "should redirect to index because there is not title" do
      get :index
      post :create, {:list => {:title => nil}}
      expect(response).to redirect_to("/")
    end

    it "should be redirect to /slug " do
      get :index
      post :create, {:list => {:title => 'alta lista aca'}}
      expect(response).to redirect_to("/alta-lista-aca")
    end

    it "should be redirect to index because the slug it is already taken" do
      get :index
      List.create({title:'lista que se repite', slug:'lista-que-se-repite'})
      post :create, {:list => {:title => 'lista que se repite'}}
      expect(response).to redirect_to("/")
    end
  end

  describe "Order of tasks" do
  
    it "should be ordered" do 
      list = List.create({title:'lista nueva', slug:'lista-nueva'})
      
      State.create([{name:'Pending'},{name:'Finished'},{name:'In progress'},{name:'Expired'}])
      Priority.create([{name:'High'}, {name:'Medium'}, {name:'Low'}])
      p = State.find_by(name:'Pending')
      f = State.find_by(name:'Finished')
      ip = State.find_by(name:'In progress')
      h = Priority.find_by(name:'High')
      m = Priority.find_by(name:'Medium')
      l = Priority.find_by(name:'Low')

      Task.create([
        {type:'Large', description:'Hola tarea larga acá', list:list, state:p, priority:l, percent:50},
        {type:'Simple', description:'Hola tarea simple', list:list, state:p, priority:m},
        {type:'Temporary', description:'Terminar trabajo final de ruby', list:list, state:p, priority:h, since: Time.now, until: DateTime.new(2017,12,25) },
      ])
      
      get :show, {id:'lista-nueva'}

      expect(assigns(:test)).to match_array(['Terminar trabajo final de ruby','Hola tarea simple', 'Hola tarea larga acá'])

    end
  
  end

  describe "when the until day is in the past" do

    it "should not show a expired task" do
      list = List.create({title:'lista dos', slug:'lista-dos'})
      State.create([{name:'Pending'},{name:'Finished'},{name:'In progress'},{name:'Expired'}])
      Priority.create([{name:'High'}, {name:'Medium'}, {name:'Low'}])
      p = State.find_by(name:'Pending')
      h = Priority.find_by(name:'High')

      t = Task.create({type:'Temporary', description:'Prueba', list:list, state:p, priority:h, since: DateTime.new(2016,11,25), until: DateTime.new(2017,12,5)})
      get :show, {id:'lista-dos'}
      expect(assigns(:test)).to match_array(['Prueba'])

      t.until = DateTime.new(2016,11,29) #Now are expired
      t.save

      get :show, {id:'lista-dos'}
      expect(assigns(:test)).to match_array([]) #Empty array because the task it is expired

    end
 end

end
