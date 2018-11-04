# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test = User.create("name"=>"test", "img"=>"https://teorico.net/images/test-dgt-1.png", "email"=>"test@gmail.com", "encrypted_password"=>"2872732680cc52d839768334681993092d4e3acd", "salt"=>"a1fcc2eb3b69bba82ededccf7aafcdf5")
other = User.create("name"=>"other", "img"=>"https://teorico.net/images/test-dgt-2.png", "email"=>"other@gmail.com", "encrypted_password"=>"8f96f67f81e487f369ec920df296582dbf7196e4", "salt"=>"f0a6e1c6e07992b531db6dd817842db7")
cola = other.ingredients.create("name"=>"Coca Cola", "img"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYJHdfpLmdVNXTq9rRDaXum819bRpJ9jw0mNFGvPq1Ds3Szcq4", "description"=>"Cola is a sweet, carbonated beverage that contains caffeine and sublte vanilla flavorings.", "have"=>true, "user_id"=>2)
test.ingredients << cola
whisky = other.ingredients.create("name"=>"Jack Daniels", "img"=>"https://res.cloudinary.com/hjqklbxsu/image/upload/f_auto,fl_lossy,q_auto/v1461818654/product/bottle/2011-holiday-select.png", "description"=>"A brand of sour mash Tennessee whiskey usually around 40% ABV", "have"=>false, "user_id"=>2)
test.ingredients << whisky
bitter = test.ingredients.create("name"=>"Angostura bitters", "img"=>"https://images-na.ssl-images-amazon.com/images/I/51ZNdpjGgIL._SX385_.jpg", "description"=>"Angostura Bitters are made from forty different tropical herbs and spices,\r\nalong with alcohol and water, and bottled at 44.7% ABV.", "have"=>true, "user_id"=>1)
vermouth = test.ingredients.create("name"=>"Red Vermouth", "img"=>"https://applejack.com/site/images/M-R-Sweet-Vermouth-375-ml_1.png", "description"=>"A swwet vermouth with fewer herbal tones than white vermouth.", "have"=>false, "user_id"=>1)
ice = test.ingredients.create("name"=>"Ice", "img"=>"https://www.ansellchiropractic.com.au/wp-content/uploads/2016/11/ice-300x261.jpg", "description"=>"Ice is the clear, frozen form of water used to chill drinks.\\n Ice is used", "have"=>true, "user_id"=>1)
whisky_cola = other.cocktails.create("name"=>"Whisky Cola", "img"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXufRBWcP-LyOrbRicUusnpRL7zqeAmo248xR2l7H1c9vO4NuN", "description"=>"Very simple and popular. Wasting scotch single malt whiskey on this one is not recommended.", "recipe"=>"1. Fill collins glass with ice\r\n2. Pour 50ml Jack Daniels or other whiskey and 150ml Cola over ice.\r\n3. Stir gently.", "user_id"=>2)
whisky_cola.ingredients << whisky
whisky_cola.ingredients << cola
test.cocktails << whisky_cola
manhattan = test.cocktails.create("name"=>"Manhattan", "img"=>"https://cdn.liquor.com/wp-content/uploads/2012/09/04121600/bourbon-manhattan.jpg", "description"=>"According to the most popular legend, this IBA official cocktail was invented at the Manhattan club in New york in the early 1870s.", "recipe"=>"1. Fill mixing glass with ice cubes.\r\n2. Pour 50ml whisky with 20ml Red Vermouth into mixing glass.\r\n3. Add 1 dash of Angostura Bitters.\r\n4. Stirr well and strain into chilled cocktail glass.", "user_id"=>1)
manhattan.ingredients << bitter
manhattan.ingredients << vermouth
manhattan.ingredients << whisky
Notification.create("user_id"=>1, "sender"=>2, "item"=>1, "item_type"=>1, "seen"=>false)
Notification.create("user_id"=>1, "sender"=>2, "item"=>2, "item_type"=>1, "seen"=>false)
Notification.create("user_id"=>1, "sender"=>2, "item"=>1, "item_type"=>0, "seen"=>false)