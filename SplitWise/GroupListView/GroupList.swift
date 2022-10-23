//
//  GroupList.swift
//  SplitWise
//
//  Created by  Oleg Ponomarev on 20.10.2022.
//

import Foundation

struct GroupList {
    private var groupList: [String] = ["Monday Burger King", "Tuesday Sushi"]
    private var totalAmount = 0
    
    public func getGroupListCount() -> Int {
        return groupList.count
    }

    public func getGroupList() -> [String] {
        return groupList
    }
}
