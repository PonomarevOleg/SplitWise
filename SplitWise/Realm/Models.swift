import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var secondName = ""
   
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ContactGroup: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var dateCreated = NSDate()
    @objc dynamic var bill: Float = 0
    @objc dynamic var isAchieved = false
    var memberList = List<Member>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class Member: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var isMarked = false
    var contact: Contact?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
