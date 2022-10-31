import UIKit
import RealmSwift

class ContactListViewController: UIViewController {
    private let viewModel = ContacListViewModel()
//    private let addVC = AddContactViewController()
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addContactButton: UIButton!

    @IBOutlet var but: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContactButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        tableView.register(UINib(
            nibName: "ContactTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "ContactTableViewCell")
        view.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
//        addVC.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.updateContactList()
        tableView.reloadData()
    }
    
    @objc func tapAddButton() {
        let vc = AddContactViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappa() {
        tableView.reloadData()
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            viewModel.deleteContact(index: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.contactList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ContactTableViewCell",
                for: indexPath
        ) as? ContactTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .orange
        cell.config(
            name: viewModel.contactList[indexPath.row].name,
            secondName: viewModel.contactList[indexPath.row].secondName
        )
        
         return cell
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}
//extension ContactListViewController: AddContactDelegate {
//    func reloadList() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//}
