import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet private var contactNameLabel: UILabel!
    @IBOutlet private var secondNameLabel: UILabel!
    
        override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func config(name: String, secondName: String) {
        contactNameLabel.text = name
        contactNameLabel.contentMode = .scaleAspectFill
        secondNameLabel.text = secondName
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = true
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
