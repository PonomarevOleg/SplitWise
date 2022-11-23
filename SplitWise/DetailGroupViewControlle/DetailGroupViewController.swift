import UIKit
import SwiftUI
import RealmSwift

class DetailGroupViewController: UIViewController {
    var viewModel: DetailGroupViewModel?
    @IBOutlet private var memberTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        configue()
    }
    
    private func configue() {
        memberTableView.register(UINib(
            nibName: "DetailGroupTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "DetailGroupTableViewCell")
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.reloadData()
    }
    
    private func setupViewModel() {
            viewModel?.setup { [weak self] (change: ObjectChange<Object>) in
                guard
                    let self = self,
                    let tableView = self.memberTableView
                else { return }

                // swiftlint:disable empty_enum_arguments
                switch change {
                case .change(_, _):
                    tableView.reloadData()
                default: print("")
                }
            }
        }
    
}

extension DetailGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.detailGroup.memberList.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let changeStatus = UIContextualAction(
            style: .normal,
            title: "Mark")
        { _,_,completion in
            guard let viewModel = self.viewModel else {return}
            viewModel.modifyMember(index: indexPath.row)
            completion(true)
            self.memberTableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [changeStatus])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let viewModel = viewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailGroupTableViewCell", for: indexPath) as? DetailGroupTableViewCell
        else { return UITableViewCell() }
        
        cell.backgroundColor = viewModel.detailGroup.memberList[indexPath.row].isMarked ? .green : .red
        cell.configue(
            name: viewModel.detailGroup.memberList[indexPath.row].contact?.name ?? "",
            bill: String(viewModel.getPersonalBill())
        )
        
        return cell
    }
}
