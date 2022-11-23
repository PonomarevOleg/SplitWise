import UIKit
import RealmSwift

class ContactListViewController: UIViewController {
    private var viewModel: ContacListViewModel?
    @IBOutlet private var contactTableView: UITableView!
    @IBOutlet private var addContactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewModel()
    }
    
    @objc func tapAddButton() {
        let vc = AddContactViewController()
        print(Realm.Configuration.defaultConfiguration)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setup() {
        addContactButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        contactTableView.register(UINib(
            nibName: "ContactTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "ContactTableViewCell")
        view.backgroundColor = .green
        contactTableView.delegate = self
        contactTableView.dataSource = self
    }
    
    private func setupViewModel() {
        viewModel = ContacListViewModel { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.contactTableView else { return }

                switch changes {
                case .initial:
                    tableView.reloadData()
                    
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.performBatchUpdates {
                        tableView.deleteRows(
                            at: deletions.map { IndexPath(row: $0, section: 0) },
                            with: .automatic
                        )
                        tableView.insertRows(
                            at: insertions.map { IndexPath(row: $0, section: 0) },
                            with: .automatic
                        )
                        tableView.reloadRows(
                            at: modifications.map { IndexPath(row: $0, section: 0) },
                            with: .automatic
                        )
                    }

                case .error(let error):
                    print(error)
                }
            }
        }
    
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if editingStyle == .delete
        {
            viewModel.deleteContact(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewModel = viewModel,
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
}
