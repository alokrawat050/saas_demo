# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Plan.create!(:name => "Single Ads", :price => 5, :users => 1)
Plan.create!(:name => "Multiple Ads", :price => 12, :users => 5)
Plan.create!(:name => "Comming Soon Ads", :price => 49, :users => 20)
