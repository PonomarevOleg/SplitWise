import UIKit

class ContactListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var contacts = ContactList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(
            nibName: "ContactTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "ContactTableViewCell")
        view.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.getContactListCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "reuseIdentifier",
                for: indexPath
        ) as? ContactCellTableViewCell else { return UITableViewCell() }
//        cell.
        cell.config(
            text: contacts.getContactList()[indexPath.row],
            imageName: contacts.getContactImageName()[indexPath.row]
        )
//        cell.imageHeight(cellHeight: cell.frame.size.height)
//        cell.backgroundColor = .orange
//        
        cell.configCellStyle()
         return cell
    }
    
}

