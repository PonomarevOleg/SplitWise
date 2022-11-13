import UIKit

class GroupInfoViewController: UIViewController, UITextFieldDelegate {
    private let viewModel = GroupInfoViewModel()
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var billLabel: UILabel!
    @IBOutlet private var billTextField: UITextField!
    @IBOutlet private var groupNameTextField: UITextField!
    
    
    @IBAction private func addContactButton(_ sender: Any) {
        if groupNameTextField.text != "" && billTextField.text != "" {
            if let name = groupNameTextField.text,
               let bill = Float(billTextField.text!) {
                let vc = ChooseMemberViewController()
                let choosenMemberViewModel = ChooseMemberViewModel()
                choosenMemberViewModel.setupGroup(name: name, secondName: String(bill))
                vc.viewModel = choosenMemberViewModel
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        nameLabel.text = "Название встречи"
        billLabel.text = "Введите счет"
        billTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            switch textField.tag{
            case 0: viewModel.name = updatedText
            case 1:
                let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
                
                let components = string.components(separatedBy: inverseSet)
                
                let filtered = components.joined(separator: "")
                
                if filtered == string {
                    return true
                } else {
                    if string == "." {
                        let countdots = textField.text!.components(separatedBy:".").count - 1
                        if countdots == 0 {
                            viewModel.bill = Float(updatedText) ?? 0
                            return true
                        }else{
                            if countdots > 0 && string == "." {
                                return false
                            } else {
                                viewModel.bill = Float(updatedText) ?? 0
                                return true
                            }
                        }
                    }else{
                        return false
                    }
                }
            default: return true
            }
        }
        return true
        
        
    }
}

