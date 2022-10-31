import Foundation

class GroupInfoViewModel{
    var groupList = ContactGroup()
    var vc = GroupInfoViewController()
    
    func addGroup(completion: (() -> ())?) {
        DataBaseManager.shared.save(object: groupList){
            completion?()
        }
    }
}
