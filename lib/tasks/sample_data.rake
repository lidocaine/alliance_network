require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
  end
end

def make_users
  me = User.create!(:username => "Lidocaine",
                    :first_name => "MJ",
                    :last_name => "Watkins",
                    :email => "c14h22n2o@gmail.com",
                    :password => "katenleo",
                    :password_confirmation => "katenleo")
  me.toggle!(:admin)
  #me.toggle!(:astrosexy)
  
  lauren = User.create!(:username => "KumoNoYume",
                        :first_name => "Lauren",
                        :last_name => "Smith",
                        :email => "kumonoyume@gmail.com",
                        :password => "spiderdreams",
                        :password_confirmation => "spiderdreams")
  lauren.toggle!(:admin)
  #lauren.toggle!(:astrosexy)
  
  darren = User.create!(:username => "Justice272",
                        :first_name => "Darren",
                        :last_name => "Mullen",
                        :email => "dmullenii@hotmail.com",
                        :password => "toussen",
                        :password_confirmation => "toussen")
  
  
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