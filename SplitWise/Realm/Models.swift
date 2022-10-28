import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var secondName = ""
    @objc dynamic var count = 0
    
    override static func primaryKey() -> String? {
        return "personID"
      }
}
