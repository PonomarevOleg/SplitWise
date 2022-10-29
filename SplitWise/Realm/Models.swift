import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var secondName = ""
    @objc dynamic var count = 0
    

    /**
    Some persisted value
    */
    dynamic var someString: String?

    var nextID: String {
        do {
            let realm = try Realm()

            var id: String = NSUUID().uuidString

            /// NSUUID().UUIDString almost always makes a unique ID on the first try
            /// but we'll check after we generate the first one just to be sure
            while realm.object(ofType: Contact.self, forPrimaryKey: id) != nil {
                id = NSUUID().uuidString
            }

        } catch let error as NSError {
            /// Oops
            print(error.localizedDescription)
        }
        return id
    }

    convenience init(someString: String?) {
        self.init()

        id = nextID
        self.someString = someString
        save()
    }

    override class func primaryKey() -> String? {
        return "id"
    }

    func save() {
        /// Gotta check this in case the object was created without using the convenience init
        if id == "" { id = nextID }

        do {
            let realm = try Realm()
            try realm.write {
                /// Add... or update if already exists
                realm.add(self, update: .error)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
