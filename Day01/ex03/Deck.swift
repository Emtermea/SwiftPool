import Foundation

class Deck : NSObject {

    static let allSpades : [Card] = Value.allValues.map {
        (value) -> Card in
        let card = Card (c : Color.spade, v : value)
        return card
    }

    static let allDiamonds : [Card] = Value.allValues.map {
       (value) -> Card in
        let card = Card (c : Color.diamond, v : value)
       return card
    }

    static let allHearts : [Card] = Value.allValues.map {
        (value) -> Card in
        let card = Card (c : Color.heart, v : value)
        return card
    }

    static let allClubs : [Card] = Value.allValues.map {
        (value) -> Card in
        let card = Card (c : Color.club, v : value)
        return card
    }

    static let allCards : [Card] = {

		var tab = [Card]()
        tab += allDiamonds
        tab += allSpades
        tab += allClubs
        tab += allHearts
        return tab
	}()

	func getCards() -> [Card] {
        return Deck.allCards
    }
}

extension Array {
    mutating func shuffle() {
		for i in 0..<count {
			let rdm = Int(arc4random_uniform(UInt32(count)))
			if i != rdm {
				swap(&self[i], &self[rdm])
			}
    	}
	}
}
