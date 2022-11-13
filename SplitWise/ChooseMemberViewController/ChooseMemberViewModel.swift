import Foundation

class ChooseMemberViewModel{
    var groupList = [Contact]()
    var choosenMembers = [Member]()
    private var name: String = ""
    private var secondName: String = ""
    
    init(){
        updateContactList()
    }

    func updateContactList() {
        groupList = DataBaseManager.shared.getObjects(type: Contact.self).toArray(ofType: Contact.self)
    }

    func createGroup(completion: (() -> ())?) {
        let group = ContactGroup()
        group.name = name
        group.bill = Float(secondName) ?? 0
        choosenMembers.forEach { member in
            group.memberList.append(member)
        }
        DataBaseManager.shared.save(object: group) {
            completion?()
        }
    }
    
    func setupGroup(name: String, secondName: String) {
        self.name = name
        self.secondName = secondName
    }
    
}


