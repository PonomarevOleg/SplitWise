import Foundation

class ContacListViewModel{
    var contactList = [Contact]()
    
    init(){
        contactList = DataBaseManager.shared.getObjects(type: Contact.self).toArray(ofType: Contact.self)
    }
}
