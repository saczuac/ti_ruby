require 'rails_helper'

RSpec.describe Task, :type => :model do
  
  it "is not valid without arguments" do
  	task = Task.new(nil)
  	expect(task).to_not be_valid  
  end

  it "is valid with all arguments" do
  	a = State.create({name:'Pending'})
  	b = Priority.create({name:'High'})
  	task = Task.new(description:'Hola', type:'Simple', list:'0', state:a, priority: b)
  	expect(task).to be_valid  
  end

  it "is not valid with inverted dates" do
  	a = State.create({name:'Pending'})
  	b = Priority.create({name:'High'})
  	task = Task.new(description:'Hola', type:'Temporary', list:'0', state:a, priority: b, since: Date.today, until: Date.today-1.day)
  	expect(task).to_not be_valid  
  end

  it "is not valid with a percent major of 100" do
    a = State.create({name:'Pending'})
    b = Priority.create({name:'High'})
    task = Task.new(description:'Hola', type:'Large', percent:110, list:'0', state:a, priority: b)
    expect(task).to_not be_valid  
  end

  it "shouldnt update the task with a invalid percent" do
    a = State.create({name:'Pending'})
    b = Priority.create({name:'High'})
    task = Task.new(description:'Hola', type:'Large', percent:50, list:'0', state:a, priority: b)
    expect(task).to be_valid  
    task.percent = 110
    expect(task).to_not be_valid
  end

end