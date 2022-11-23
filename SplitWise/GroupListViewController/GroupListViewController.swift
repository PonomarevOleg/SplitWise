import UIKit
import RealmSwift

class GroupListViewController: UIViewController {
    private var viewModel: GroupListViewModel?
    @IBOutlet private var groupTable: UITableView!
    @IBOutlet var addGroupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        configue()
    }
    
    private func configue() {
        addGroupButton.addTarget(self, action: #selector(addGroup), for: .touchUpInside)
        groupTable.register(
            UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupTableViewCell")
        groupTable.delegate = self
        groupTable.dataSource = self
    }
    
    @objc private func addGroup() {
        let vc = GroupInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupViewModel() {
        viewModel = GroupListViewModel { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.groupTable else { return }

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

extension GroupListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.groupList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if editingStyle == .delete {
            viewModel.deleteContact(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let vc = DetailGroupViewController()
        let detailedViewModel = DetailGroupViewModel()
        detailedViewModel.detailGroup = viewModel.groupList[indexPath.row]
        vc.viewModel = detailedViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewModel = viewModel,
            let cell = groupTable.dequeueReusableCell(
                withIdentifier: "GroupTableViewCell",
                for: indexPath
            ) as? GroupTableViewCell
        else { return UITableViewCell() }
        cell.config(
            name: viewModel.groupList[indexPath.row].name,
            bill: String(viewModel.groupList[indexPath.row].bill)
        )
        
        cell.backgroundColor = viewModel.groupList[indexPath.row].isAchieved ? .gray : .green
        
        return cell
    }
}
