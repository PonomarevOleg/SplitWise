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
    @objc dynamic var bill = 0
    var contactGroup = List<Member>()
    
    override init() {
        self.name = ""
        
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class Member: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var isMarked = false
    @objc dynamic var contact: Contact?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
