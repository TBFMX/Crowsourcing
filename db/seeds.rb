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
Rol.create(rol_name: 'rol_admin', admin: true, module_1: true, module_2: true, module_3: true, module_4: true, module_5: true)
Rol.create(rol_name: 'tecnico', admin: false, module_1: true, module_2: true, module_3: true, module_4: true, module_5: true)
User.create(username: 'admin', password: 'k4st3lJY!', password_confirmation: 'k4st3lJY!', email: 'admin@admin.com', rol_id: 1)
