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
    }
    
    func configCellStyle() {
        contactImageView.layer.cornerRadius = contactImageView.frame.width / 2
        contactImageView.contentMode = .scaleAspectFit
        
    }
    
    func imageHeight(cellHeight: CGFloat) {
        contactImageView.frame.size.height = cellHeight - 10
    }
}
