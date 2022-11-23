import UIKit

class DetailGroupTableViewCell: UITableViewCell {
    
    @IBOutlet private var memberNameLabel: UILabel!
    @IBOutlet private var memberBillLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configue(name: String, bill: String) {
        memberNameLabel.text = name
        memberBillLabel.text = bill
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = true
        memberBillLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
