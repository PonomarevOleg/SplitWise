import UIKit

class ChooseMemberViewController: UIViewController {
    var viewModel: ChooseMemberViewModel?
    @IBOutlet private var newGroupTable: UITableView!
    @IBAction private func createGroupButton(_ sender: Any) {
        confirm()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        configue()
    }
    
    func configue() {
        newGroupTable.register(UINib(
            nibName: "MemberTableViewCell",
            bundle: nil),
            forCellReuseIdentifier: "MemberTableViewCell"
        )
        newGroupTable.allowsMultipleSelection = true
        newGroupTable.delegate = self
        newGroupTable.dataSource = self
    }
    
    func confirm() {
        confirmAlert(
            title: "Alert",
            massage: "Confirm group",
            alertStyle: .alert,
            actionTitles: ["Подтвердите создание группы", "Отмена"],
            actionStyles: [.default, .cancel],
            actions: [
                {_ in
                    print("okay click")
                    self.viewModel?.createGroup(completion: {
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                },
                {_ in
                    print("cancel click")
                }
            ]
        )
    }
}

extension ChooseMemberViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.groupList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {return}
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        let contact = viewModel.groupList[indexPath.row]
        let member = Member()
        member.contact = contact
        if !viewModel.choosenMembers.contains(member){
            viewModel.choosenMembers.append(member)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {return}
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
        let contact = viewModel.groupList[indexPath.row]
        let member = Member()
        member.contact = contact
        if !viewModel.choosenMembers.contains(member){
            viewModel.choosenMembers.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewModel = viewModel,
            let cell = newGroupTable.dequeueReusableCell(
                withIdentifier: "MemberTableViewCell",
                for: indexPath
            ) as? MemberTableViewCell
        else { return UITableViewCell() }
        cell.backgroundColor = .green
        cell.config(
            name: viewModel.groupList[indexPath.row].name,
            secondName: viewModel.groupList[indexPath.row].secondName
        )
        return cell
    }
}

protocol ChooseMemberViewDelegate: ChooseMemberViewController {
    func setupGroupInfo(name: String, bill: Int)
}

extension ChooseMemberViewController {
    func confirmAlert(title: String,
                      massage: String,
                      alertStyle: UIAlertController.Style,
                      actionTitles: [String],
                      actionStyles: [UIAlertAction.Style],
                      actions: [((UIAlertAction) -> Void)]
    ) {
        let alertController = UIAlertController(title: title,
                                                message: massage,
                                                preferredStyle: alertStyle)
        for (index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle,
                                       style: actionStyles[index],
                                       handler: actions[index]
            )
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
