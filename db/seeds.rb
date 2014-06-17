# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count > 0
	User.delete_all
end
if Rol.count > 0
	Rol.delete_all
end
if Project.count > 0
	Project.delete_all
end
Rol.create(rol_name: 'rol_admin', admin: true, module_1: true, module_2: true, module_3: true, module_4: true, module_5: true)
Rol.create(rol_name: 'tecnico', admin: false, module_1: true, module_2: true, module_3: true, module_4: true, module_5: true)
User.create(username: 'admin', password: 'k4st3lJY!', email: 'admin@admin.com', rol_id: 1)
User.create(username: 'demo', password: 'demo' ,  email: 'sebastian@tbf.mx', rol_id: 2)
#crear proyecto
Project.create(name: 'demo', monetary_goal: 0.00  ,image_id: 1 ,  user_id: 1)
#crear galeria
Gallery.create(title:'principal', description:'galeria principal del proyecto', project_id: 1)
#crear imagen
Image.create(image_url: '/data/lobo_aullando_a_la_luna-1280x960.jpg', galery_id: 1)


#creamos el perk
Perk.create(title: 'Sub-Demo' ,description: 'este es un producto de demostración', price: 100.00 ,pieces: 1 ,project_id: 1)

