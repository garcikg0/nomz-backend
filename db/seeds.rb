# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create(
#   first_name: "Admin",
#   last_name: "Admin",
#   username: "admin",
#   email: "admin@test.co",
#   bio: "admin test",
#   password_digest: "admin"
# )

# Kitchen.create(user_id: 1, name: "NYC Apartment")

Ingredient.create(
    kitchen_id: 1,
    name: "Dairy",
    storage: "Fridge",
    icon: "https://static.thenounproject.com/png/2942672-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Fruit",
    storage: "Pantry",
    icon: "https://static.thenounproject.com/png/1422989-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Spices",
    storage: "Pantry",
    icon: "https://static.thenounproject.com/png/1317943-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Flour",
    storage: "Pantry",
    icon: "https://static.thenounproject.com/png/1015530-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Vegetables",
    storage: "Pantry",
    icon: "https://static.thenounproject.com/png/1434570-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Seafood",
    storage: "Freezer",
    icon: "https://static.thenounproject.com/png/3478937-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Condiments",
    storage: "Fridge",
    icon: "https://static.thenounproject.com/png/1317946-200.png",
    status: "Available",
    notes: ""
)

Ingredient.create(
    kitchen_id: 1,
    name: "Poultry",
    storage: "Fridge",
    icon: "https://static.thenounproject.com/png/2327576-200.png",
    status: "Available",
    notes: ""
)

# Recipe.create(
#     user_id: 1,
#     name: "Roasted Brussels Sprouts And Crispy Baked Tofu With Honey-Sesame Glaze",
#     image: "https://www.edamam.com/web-img/254/254a1027e396a977f8ba5dd8cac9adc5.jpg",
#     source: "cookieandkate.com",
#     url: "http://cookieandkate.com/2014/roasted-brussels-sprouts-and-crispy-baked-tofu-with-honey-sesame-glaze/",
#     ingredient_lines: [
#       "1¼ cup brown rice, preferably short grain",
#       "1½ pound Brussels sprouts",
#       "1½ tablespoons olive oil",
#       "Fine grain sea salt",
#       "1 (15 ounce) block of organic extra-firm tofu",
#       "1 tablespoon olive oil",
#       "1 tablespoon reduced-sodium tamari or soy sauce",
#       "1 tablespoon arrowroot starch or cornstarch",
#       "¼ cup reduced-sodium tamari or soy sauce",
#       "3 tablespoons honey (maple syrup also works)",
#       "2 tablespoons rice vinegar",
#       "2 teaspoons toasted sesame oil",
#       "1 to 3 teaspoons chili garlic sauce or sriracha (depending on how spicy you like it)",
#       "2 tablespoons sesame seeds",
#       "Big handful fresh cilantro leaves, chopped"
#     ],
#     ingredients: [
#       {
#         text: "1¼ cup brown rice, preferably short grain",
#         weight: 237.5,
#         image: "https://www.edamam.com/food-img/c45/c453c255234a6f7f798d3f2aaa74bbcd.jpg",
#       },
#       {
#         text: "1½ pound Brussels sprouts",
#         weight: 680.388555,
#         image: "https://www.edamam.com/food-img/28a/28a88a795cd97a3b3b28b65eb8bff5aa.jpg"
#       },
#       {
#         text: "1½ tablespoons olive oil",
#         weight: 20.25,
#         image: "null"
#       },
#       {
#         text: "Fine grain sea salt",
#         weight: 9.552188411249187,
#         image: "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg"
#       },
#       {
#         text: "1 (15 ounce) block of organic extra-firm tofu",
#         weight: 425.242846875,
#         image: "https://www.edamam.com/food-img/b6a/b6ae13c3cfe37e16f820840f90231bff.jpg"
#       },
#       {
#         text: "1 tablespoon olive oil",
#         weight: 13.5,
#         image: "null"
#       },
#       {
#         text: "1 tablespoon reduced-sodium tamari or soy sauce",
#         weight: 16,
#         image: "https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg"
#       },
#       {
#         text: "1 tablespoon arrowroot starch or cornstarch",
#         weight: 7.999999999864745,
#         image: "https://www.edamam.com/food-img/f9b/f9b74d9495b40c0aea955c37a1fc39dc.jpg"
#       },
#       {
#         text: "¼ cup reduced-sodium tamari or soy sauce",
#         weight: 63.75,
#         image: "https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg"
#       },
#       {
#         text: "3 tablespoons honey (maple syrup also works)",
#         weight: 63,
#         image: "https://www.edamam.com/food-img/198/198c7b25c23b4235b4cc33818c7b335f.jpg"
#       },
#       {
#         text: "2 tablespoons rice vinegar",
#         weight: 29.8,
#         image: "https://www.edamam.com/food-img/5f6/5f69b84c399d778c4728e9ab4f8065a2.jpg"
#       },
#       {
#         text: "2 teaspoons toasted sesame oil",
#         weight: 9,
#         image: "https://www.edamam.com/food-img/b87/b874ddcfb6770adc7a155355a902ffb8.jpg"
#       },
#       {
#         text: "1 to 3 teaspoons chili garlic sauce or sriracha (depending on how spicy you like it)",
#         weight: 5.6,
#         image: "https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg"
#       },
#       {
#         text: "2 tablespoons sesame seeds",
#         weight: 18,
#         image: "https://www.edamam.com/food-img/291/291b355a7a0948716243164427697279.jpg"
#       },
#       {
#         text: "Big handful fresh cilantro leaves, chopped",
#         weight: 2,
#         image: "https://www.edamam.com/food-img/d57/d57e375b6ff99a90c7ee2b1990a1af36.jpg"
#       }
#     ]
# )