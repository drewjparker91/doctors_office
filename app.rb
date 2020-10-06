require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "doctors_office"})

get('/') do
  redirect to('/doctors')
end

get('/doctors') do
  @doctors = Doctor.all
  erb(:doctors)
end

get ('/doctors/new') do
  erb(:new_doctor)
end

get ('/doctors/:id') do
  @doctor = Doctor.find(params[:id].to_i())
  erb(:doctor)
end

get ('/albums/:id/edit') do
  @doctor = Doctor.find(params[:id].to_i())
  erb(:edit_doctor)
end

post ('/doctors') do
  name = params[:doctor_name]
  specialty = params[:doctor_specialty]
  doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  doctor.save()
  redirect to('/doctors')
end

patch ('/doctors/:id') do
  @doctor = Doctor.find(params[:id].to_i())
  @doctor.update(params[:name])
  @doctor.update(params[:specialty])
  redirect to('/doctors')
end

delete ('/doctors/:id') do
  @doctor = Doctor.find(params[:id].to_i())
  @doctor.delete()
  redirect to('/doctors')
end
