# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p = State.create({name:'Pendiente'})
a = Priority.create({name:'Alta'})

State.create([{name:'Pendiente'},{name:'Realizada'},{name:'En curso'},{name:'Expirada'}])
Priority.create([{name:'Alta'}, {name:'Media'}, {name:'Baja'}])

Task.create([{type:'Large', description:'Hola tarea larga acá', list:'genio-total', state:p, priority:a, percent:50},{type:'Simple', description:'Hola tarea simple', list:'genio-total', state:p, priority:a}])