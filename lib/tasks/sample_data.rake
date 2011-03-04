require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
  end
end

def make_users
  admin = User.create!(:username => "Lidocaine",
                       :first_name => "MJ",
                       :last_name => "Watkins",
                       :email => "mwatkins@whoshotjane.com",
                       :password => "katenleo",
                       :password_confirmation => "katenleo")
  admin.toggle!(:admin)
  #admin.toggle!(:astrosexy)
  
  20.times do |n|
    uname = "DemoUser#{n+1}"
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    email = Faker::Internet.email
    password = "password"
    
    User.create!(:username => uname,
                 :first_name => fname,
                 :last_name => lname,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end