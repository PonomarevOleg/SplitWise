//
//  GroupInfoViewController.swift
//  SplitWise
//
//  Created by  Oleg Ponomarev on 30.10.2022.
//

import UIKit

class GroupInfoViewController: UIViewController {
    private var viewModel = GroupInfoViewModel()
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var groupNameTextField: UITextField!
    @IBOutlet var billLabel: UILabel!
    @IBOutlet var billTextField: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    func setup() {
        nameLabel.text = "Введите название встречи"
        billLabel.text = "Введите счет"
    }
}
