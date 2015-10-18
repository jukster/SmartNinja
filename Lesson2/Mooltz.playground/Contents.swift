import Foundation

// Ali se enum declara globalno ali znotraj Class declaration?

enum State: Int {
    case Active = 0, Inactive
}

enum Priority: Int {
    case Normal, High
}

class Item {
    var name: String {
        didSet {
            self.dateModified = NSDate()
        }
    }
    
    let dateCreated: NSDate
    
    var dateModified: NSDate

    var state = State(rawValue: 0) {
        didSet {
            self.dateModified = NSDate()
        }
    }

    var priority = Priority(rawValue: 0) {
        didSet {
            self.dateModified = NSDate()
        }
    }

    func description() -> String {
        return "Predmet \(name), ustvarjen \(dateCreated). Status "
    }
    
    init(name: String) {
        self.name = name
        self.dateCreated = NSDate()
        self.dateModified = NSDate()
    }
    
    convenience init() {
        self.init(name: "Nov predmet")
    }
}

var prva = Item(name: "prva")

print(prva.dateCreated.description)

print(prva.state)

print(prva.dateCreated)

print(prva.priority)

var drug = Item()

drug.name