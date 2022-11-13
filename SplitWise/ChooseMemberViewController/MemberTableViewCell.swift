import UIKit

class MemberTableViewCell: UITableViewCell {
    @IBOutlet private var contactNameLabel: UILabel!
    @IBOutlet private var billLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func config(name: String, secondName: String) {
        contactNameLabel.text = name
        billLabel.text = secondName
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = true
        billLabel.translatesAutoresizingMaskIntoConstraints = true
    }
}
