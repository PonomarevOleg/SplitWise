import Foundation

class AddContactViewModel {
    var contact = Contact()
    var vc = ContactListViewController()
    
    func addContact(completion: (() -> ())?) {
        DataBaseManager.shared.save(object: contact){
            completion?()
        }
    }
}
