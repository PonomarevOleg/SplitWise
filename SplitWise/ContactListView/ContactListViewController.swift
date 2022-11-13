import UIKit
import RealmSwift

class ContactListViewController: UIViewController {
    private let viewModel = ContacListViewModel()
    @IBOutlet private var contactTableView: UITableView!
    @IBOutlet private var addContactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration)
        addContactButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        contactTableView.register(UINib(
            nibName: "ContactTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "ContactTableViewCell")
        view.backgroundColor = .green
        contactTableView.delegate = self
        contactTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.updateContactList()
        contactTableView.reloadData()
    }
    
    @objc func tapAddButton() {
        let vc = AddContactViewController()
        print(Realm.Configuration.defaultConfiguration)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            viewModel.deleteContact(index: indexPath.row)
            self.contactTableView.reloadData()
        }
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
        cell.configue(
            name: viewModel.contactList[indexPath.row].name,
            secondName: viewModel.contactList[indexPath.row].secondName
        )
        
        return cell
    }
    
    func reloadTable() {
        contactTableView.reloadData()
    }
}
