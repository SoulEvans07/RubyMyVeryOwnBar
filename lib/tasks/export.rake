namespace :export do
  desc "Prints User, Ingredient, Cocktial, Notification tables in a seeds.rb way."
  task :seeds_format => :environment do
    User.order(:id).all.each do |country|
      puts "User.create(#{country.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Ingredient.order(:id).all.each do |country|
      puts "Ingredient.create(#{country.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Cocktail.order(:id).all.each do |country|
      puts "Cocktail.create(#{country.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Notification.order(:id).all.each do |country|
      puts "Notification.create(#{country.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end