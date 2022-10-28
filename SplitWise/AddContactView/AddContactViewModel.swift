//
//  AddContactViewModel.swift
//  SplitWise
//
//  Created by  Oleg Ponomarev on 26.10.2022.
//

import Foundation

class AddContactViewModel{
    var contact = Contact()
    
    func addContact(completion: (() -> ())?) {
        DataBaseManager.shared.save(object: contact){
            completion?()
        }
    }
}
