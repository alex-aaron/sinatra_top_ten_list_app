user1 = User.create(username: "alex_aaron", email: "sample@gmail.com", password: "1894")

user2 = User.create(username: "mrwigand", email: "sample2@gmail.com", password: "password")

user3 = User.create(username: "Stephanie Cox", email: "sample3@gmail.com", password: "helloWorld")

user1.lists.create(title: "Top Ten Films of 1999", category: "arts_and_entertainment", content: 
"1. The Insider, 2. Magnolia, 3. Election, 4. Boys Don't Cry, 5. The Matrix, 6. Ghost Dog: Way of the Samurai,
7. Being John Malkovich, 8. Fight Club, 9. Sleepy Hollow, 10. The Limey"
)

user2.lists.create(title: "Top Ten Pizza Toppings", category: "food", content: "1. Pepperoni, 2. Black Olives,
3. Mushrooms, 4. Roasted Red Peppers, 5. Pineapple, 6. Sausage, 7. Onions, 8. Green olives, 9. Hamburger,
10. Provolone")