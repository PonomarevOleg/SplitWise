import UIKit

class GroupListViewController: UIViewController {
    @IBOutlet var groupTableView: UITableView!
    private var groupList = GroupList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
}

extension GroupListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        print("Selected row: \(indexPath.row)")
    }
}

extension GroupListViewController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groupList.getGroupListCount()
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "GroupCell"
    ) as? GroupTableViewCell else { return UITableViewCell() }
    cell.backgroundColor = .purple
    cell.groupNameLabel.text = groupList.getGroupList()[indexPath.row]
    return cell
    
}
}
