import Foundation

class ContacListViewModel{
    var contactList = [Contact]()
    
    init(){
        updateContactList()
    }
    
    func updateContactList() {
        contactList = DataBaseManager.shared.getObjects(type: Contact.self).toArray(ofType: Contact.self)
    }
    
    func deleteContact(index: Int) {
        DataBaseManager.shared.deleteObject(object: contactList[index])
        updateContactList()
    }
}
