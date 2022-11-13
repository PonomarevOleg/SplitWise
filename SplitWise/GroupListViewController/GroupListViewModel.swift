import Foundation

class GroupListViewModel{
    var groupList = [ContactGroup]()
    
    init(){
        updateGroupList()
    }
    
    func updateGroupList() {
        groupList = DataBaseManager.shared.getObjects(type: ContactGroup.self).toArray(ofType: ContactGroup.self).sorted(by: { $0.dateCreated as Date > $1.dateCreated as Date}).sorted(by: { !$0.isAchieved && $1.isAchieved})
    }
    
    func deleteContact(index: Int) {
        DataBaseManager.shared.deleteObject(object: groupList[index])
        updateGroupList()
    }
}
