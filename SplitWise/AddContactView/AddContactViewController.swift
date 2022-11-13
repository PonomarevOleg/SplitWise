import UIKit
import RealmSwift

class AddContactViewController: UIViewController {
    private let viewModel = AddContactViewModel()
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var secondNameTextField: UITextField!
    @IBOutlet private var saveContactButton: UIButton!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var helpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configue()
    }
    
    func configue() {
        saveContactButton.addTarget(self, action: #selector(saveContactButtonTap), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        secondNameTextField.tag = 1
        nameTextField.delegate = self
        secondNameTextField.delegate = self
        nameTextField.placeholder = "Введите имя"
        secondNameTextField.placeholder = "Введите фамилию"
    }
    
    @objc func cancelButtonTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func saveContactButtonTap() {
        if !viewModel.contact.name.isEmpty && !viewModel.contact.secondName.isEmpty{
            viewModel.addContact { [weak self] in
                guard let self = self else { return }
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension AddContactViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            switch textField.tag{
            case 0: viewModel.contact.name = updatedText
            case 1: viewModel.contact.secondName = updatedText
            default: return true
            }
        }
        return true
    }
}
