// first card
let color1 = Color.spade
let value1 = Value.two

//second Card
let color2 = Color.heart
let value2 = Value.king

var firstCard = Card(c : color1, v : value1)
var secondCard = Card(c : color2, v : value2)

print("***** display description  *****")
print("- first card -")
print(firstCard.description)

print("- second card -")
print(secondCard.description)

print("***** test operator / isEqual method for different cards *****")
print("- operator -")
print(firstCard == secondCard)

print("- isEqual -")
print(firstCard.isEqual(secondCard))

var otherCard = firstCard

print("***** test operator / isEqual method for same cards *****")
print("- operator -")
print(firstCard == otherCard)

print("- isEqual -")
print(firstCard.isEqual(otherCard))
