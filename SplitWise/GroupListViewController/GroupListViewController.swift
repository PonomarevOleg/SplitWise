import UIKit

class GroupListViewController: UIViewController {
    private var viewModel = GroupListViewModel()
    @IBOutlet private var groupTable: UITableView!
    @IBOutlet var addGroupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.updateGroupList()
        groupTable.reloadData()
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
}

extension GroupListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteContact(index: indexPath.row)
            self.groupTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
