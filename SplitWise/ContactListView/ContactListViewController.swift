import UIKit
import RealmSwift

class ContactListViewController: UIViewController {
    private let viewModel = ContacListViewModel()
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addContactButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addContactButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        tableView.register(UINib(
            nibName: "ContactTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "ContactTableViewCell")
        view.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @objc func tapAddButton() {
        let vc = AddContactViewController()
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
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
        
       
        
        cell.configCellStyle(cellHeight: cell.frame.size.height)
        cell.imageHeight(cellHeight: cell.frame.size.height)
        cell.backgroundColor = .orange
        
         return cell
    }
    
}

