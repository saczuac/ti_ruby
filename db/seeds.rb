# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
	{type:'Large', description:'Limpiar todo el depto :(', list:'0', state:ip, priority:m, percent:20},
	{type:'Simple', description:'Hola tarea simple', list:'0', state:p, priority:m},
	{type:'Simple', description:'Barrer el departamento!', list:'0', state:p, priority:l},
	{type:'Temporary', description:'Terminar trabajo final de ruby', list:'0', state:p, priority:h, since: Time.now, until: DateTime.new(2017,12,25) },
	{type:'Temporary', description:'Estudiar para concurrente parcial el 12', list:'0', state:p, priority:m, since: Time.now, until: DateTime.new(2017,12,25)}
	])