import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet var groupName: UILabel!
    @IBOutlet var billLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(name: String, bill: String) {
        groupName.text = name
        billLabel.text = bill
        groupName.translatesAutoresizingMaskIntoConstraints = true
        billLabel.translatesAutoresizingMaskIntoConstraints = true
    }
}
