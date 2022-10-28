import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet private var contactImageView: UIImageView!
    @IBOutlet private var contactNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func config(text: String, imageName: String) {
        contactNameLabel.text = text
        contactImageView.image = UIImage(named: imageName)
        contactImageView.translatesAutoresizingMaskIntoConstraints = true
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func configCellStyle(cellHeight: CGFloat) {
        contactImageView.layer.cornerRadius = (cellHeight - 20) / 2
    }
    
    func imageHeight(cellHeight: CGFloat) {
        contactImageView.frame.size.height = cellHeight - 20
    }
}
