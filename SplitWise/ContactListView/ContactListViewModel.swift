import Foundation
import RealmSwift

class ContacListViewModel{
    var contactList = [Contact]()
    
    var notificationToken: NotificationToken?

        init(observationBlock: @escaping (RealmCollectionChange<Results<Object>>) -> Void) {
            let results = DataBaseManager.shared.getObjects(type: Contact.self)
            notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
                guard let self = self else { return }

                switch changes {
                case .initial(let collectionType):
                    self.contactList = collectionType.toArray(ofType: Contact.self)

                case .update(let collectionType, _, _, _):
                    self.contactList = collectionType.toArray(ofType: Contact.self)

                case .error(let error):
                    print(error)
                }

                observationBlock(changes)
            }
        }
   
    func deleteContact(index: Int) {
            let contact = contactList[index]

            DataBaseManager.shared.deleteObject(object: contact)
            DataBaseManager.shared.modifyObject {
                let results = DataBaseManager.shared.getObjects(type: ContactGroup.self).toArray(ofType: ContactGroup.self)
                results.forEach { group in
                    group.memberList.forEach { member in
                        if member.contact == nil, let index = group.memberList.firstIndex(of: member) {
                            group.memberList.remove(at: index)
                        }
                    }

                    if group.memberList.isEmpty {
                        DataBaseManager.shared.mainRealm.delete(group)
                    }
                }
            }
        }
}
