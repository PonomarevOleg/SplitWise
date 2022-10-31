import Foundation

class ChooseMemberViewModel{
    var contactList = [Contact]()
    
    init() {
        updateContactList()
    }
    
    func updateContactList() {
        DataBaseManager.shared.getObjects(type: Contact.self).toArray(ofType: Contact.self)
    }    
}


