//
//  ContactListModel.swift
//  SplitWise
//
//  Created by  Oleg Ponomarev on 20.10.2022.
//

import Foundation

struct ContactList {
    private var coworkerName: String = ""
    private var contactList: [String] = ["Сергей Антонов", "John Johnson", "Homer Simpson"]
    private var totalAmount = 0
    private var contactImage: [String] = ["1", "2", "3"]
     
    public func getContactListCount() -> Int {
        return contactList.count
    }

    public func getContactList() -> [String] {
        return contactList
    }
    
    public func getContactImageName() -> [String] {
        return contactImage
    }
}
