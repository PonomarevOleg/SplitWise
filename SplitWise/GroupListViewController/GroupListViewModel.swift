import Foundation
import RealmSwift

class GroupListViewModel{
    var groupList = [ContactGroup]()
    
    var notificationToken: NotificationToken?

        init(observationBlock: @escaping (RealmCollectionChange<Results<Object>>) -> Void) {
            let results = DataBaseManager.shared.getObjects(type: ContactGroup.self)
            notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
                guard let self = self else { return }

                switch changes {
                case .initial(let collectionType):
                    self.groupList = collectionType.toArray(ofType: ContactGroup.self)

                case .update(let collectionType, _, _, _):
                    self.groupList = collectionType.toArray(ofType: ContactGroup.self)

                case .error(let error):
                    print(error)
                }

                observationBlock(changes)
            }
        }
    
    func deleteContact(index: Int) {
        DataBaseManager.shared.deleteObject(object: groupList[index])
    }
}
