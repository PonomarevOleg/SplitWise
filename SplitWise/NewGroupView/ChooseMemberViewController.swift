import UIKit

class ChooseMemberViewController: UIViewController {
    private var viewModel = ChooseMemberViewModel()
    @IBOutlet var newGroupTable: UITableView!
    
    @IBAction func createGroupButton(_ sender: Any) {
        let vc = GroupInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newGroupTable.register(UINib(
            nibName: "ContactTableViewCell",
            bundle: nil),
            forCellReuseIdentifier: "ContactTableViewCell"
        )
        newGroupTable.delegate = self
        newGroupTable.dataSource = self
    }
    
    @objc func addGroup(){
        //
    }
}

extension ChooseMemberViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = newGroupTable.dequeueReusableCell(
                withIdentifier: "ContactTableViewCell",
                for: indexPath
            ) as? ContactTableViewCell
        else { return UITableViewCell() }
        
        return cell
    }
    
}
