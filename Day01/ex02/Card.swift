import Foundation

class Card : NSObject {

    var color : String
    var value : Int

    init (c :  Color, v : Value) {
        self.color = c.rawValue
        self.value = v.rawValue
    }

    override var description : String {
        return "Color : \(color), Value : \(value)"
    }

    override func isEqual(to object:  Any?) -> Bool {
        if let object = object as? Card {
			return self.value == object.value && self.color == object.color
        } else {
            return false
        }
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.value == rhs.value
    }

}
