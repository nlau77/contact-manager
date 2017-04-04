require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'
also_reload 'models/contact'

set :bind, '0.0.0.0'  # bind to all interfaces

# before do
#   contact_attributes = [
#     { first_name: 'Eric', last_name: 'Kelly', phone_number: '1234567890' },
#     { first_name: 'Adam', last_name: 'Sheehan', phone_number: '1234567890' },
#     { first_name: 'Dan', last_name: 'Pickett', phone_number: '1234567890' },
#     { first_name: 'Evan', last_name: 'Charles', phone_number: '1234567890' },
#     { first_name: 'Faizaan', last_name: 'Shamsi', phone_number: '1234567890' },
#     { first_name: 'Helen', last_name: 'Hood', phone_number: '1234567890' },
#     { first_name: 'Corinne', last_name: 'Babel', phone_number: '1234567890' }
#   ]
#
#   @contacts = contact_attributes.map do |attr|
#     Contact.new(attr)
#   end
# end

get '/' do
  @contacts = Contact.all
    #Contact.all similair to :: SELECT * FROM contacts;
  erb :index
end

get '/contacts/:id' do
  id = params[:id]
  @contact= Contact.find_by(id: id)
  erb :contact
end

post '/search' do
  search= params[:search]
  redirect "/#{search}"
end

get '/:search' do
  search= params[:search]
  @search= search[0].upcase + search[1..-1].downcase
  @articles_first_name = Contact.where(first_name: @search)
  @articles_last_name = Contact.where(last_name: @search)
  @articles_phone_number = Contact.where(phone_number: @search)
  # binding.pry
  erb :search
end
