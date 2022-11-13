import Foundation

class DetailGroupViewModel{
    
    var detailGroup = ContactGroup()
    
    func modifyMember(index: Int) {
        DataBaseManager.shared.modifyObject(block: {
            let isMarked = self.detailGroup.memberList[index].isMarked
            self.detailGroup.memberList[index].isMarked = !isMarked
            let isAchieved = self.detailGroup.memberList.allSatisfy { $0.isMarked }
            self.detailGroup.isAchieved = isAchieved
        })
    }
}
