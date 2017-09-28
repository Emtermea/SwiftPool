//import UIKit

// for loop enum
// Appcode

print("----- display static let of Color enum -----")
for c in Color.allColors{
    print(c.rawValue)
}
print("----- test for specific card -----")
let color = Color.diamond
let value = Value.ten
print(color.rawValue)
print(value.rawValue)

print("----- display static let of Value enum -----")
for v in Value.allValues{
    print(v.rawValue)
}
