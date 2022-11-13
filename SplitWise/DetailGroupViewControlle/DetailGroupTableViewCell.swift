import UIKit

class DetailGroupTableViewCell: UITableViewCell {
    
    @IBOutlet private var memberNameLabel: UILabel!
    @IBOutlet private var memberSecondNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configue(name: String, secondName: String) {
        memberNameLabel.text = name
        memberNameLabel.text = secondName
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = true
        memberSecondNameLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
