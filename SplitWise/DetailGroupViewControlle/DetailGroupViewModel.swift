import Foundation
import RealmSwift

class DetailGroupViewModel{
    
    var detailGroup = ContactGroup()
    var notificationToken: NotificationToken?
   
    func getPersonalBill() -> Float {
        return detailGroup.bill / Float(detailGroup.memberList.count)
    }
    
    func modifyMember(index: Int) {
        DataBaseManager.shared.modifyObject(block: {
            let isMarked = self.detailGroup.memberList[index].isMarked
            self.detailGroup.memberList[index].isMarked = !isMarked
            let isAchieved = self.detailGroup.memberList.allSatisfy { $0.isMarked }
            self.detailGroup.isAchieved = isAchieved
        })
    }
    func setup( observationBlock: @escaping (ObjectChange<Object>) -> Void) {
        notificationToken = detailGroup.observe { [weak self] (change: ObjectChange<Object>) in
            guard let self = self else { return }
            
            switch change {
            case .change(let object, _):
                if let group = object as? ContactGroup {
                    self.detailGroup = group
                }
                
            case .error(let error):
                print("An error occurred: \(error)")
                
            case .deleted:
                print("The object was deleted.")
            }
            
            observationBlock(change)
        }
    }
}
