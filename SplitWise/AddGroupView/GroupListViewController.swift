//
//  AddGroupViewController.swift
//  SplitWise
//
//  Created by  Oleg Ponomarev on 30.10.2022.
//

import UIKit

class GroupListViewController: UIViewController {
    @IBOutlet private var groupTable: UITableView!
    @IBOutlet var addGroupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addGroupButton.addTarget(self, action: #selector(addGroup), for: .touchUpInside)
        groupTable.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        groupTable.delegate = self
        groupTable.dataSource = self
    }
    
    @objc func addGroup(){
        let vc = ChooseMemberViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GroupListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = groupTable.dequeueReusableCell(
                withIdentifier: "ContactTableViewCell",
                for: indexPath
            ) as? ContactTableViewCell
        else { return UITableViewCell() }
        
        return cell
    }
    
    
}
