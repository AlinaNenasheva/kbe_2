import UIKit

class CompanyViewController: UIViewController {

    @IBOutlet weak var companyCodeTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var shortNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var bankIDTextField: UITextField!
    @IBOutlet weak var specializationTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyCodeTextField.placeholder = "XXX"
        fullNameTextField.placeholder = "CompanyName"
        shortNameTextField.placeholder = "CompName"
        addressTextField.placeholder = "StreetName st. buildingNumber"
        bankIDTextField.placeholder = "XXX"
        specializationTextField.placeholder = "medicine/programming/etc"
    }
    
    @IBAction func addCompanyButtonPressed(_ sender: Any) {
        let company: Company = Company()
        if companyCodeTextField.text != "" {
            company.code = companyCodeTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Code\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if fullNameTextField.text != "" {
            company.name = fullNameTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Full name\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if shortNameTextField.text != "" {
            company.abbreviation = shortNameTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Short name\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if addressTextField.text != "" {
            company.address = addressTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Address\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if let bankID = Int(bankIDTextField.text!) {
            company.bankID = bankID
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Bank ID\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if specializationTextField.text != "" {
            company.specialization = specializationTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Specialization\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if let _ = company.name, let _ = company.abbreviation, let _ = company.code, let _ = company.specialization, let _ = company.bankID {
            DataBase.shared.addCompany(company: company)
        }
    }
    
    @IBAction func deleteCompanyButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "What company do you want to delete?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Company code" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if alert.textFields?.first?.text != "" {
                let companyCode: String? = alert.textFields?.first?.text
                DataBase.shared.deleteCompany(companyCode: companyCode!)
            }
        }
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editCompanyButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "What company do you want to change?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Company code" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if alert.textFields?.first?.text != "" {
                let companyCode: String? = alert.textFields?.first?.text
                DataBase.shared.editCompany(companyCode: companyCode!, fullName: self.fullNameTextField.text, shortName: self.shortNameTextField.text, bankID: self.bankIDTextField.text, address: self.addressTextField.text, specialization: self.specializationTextField.text)
            }
        }
        alert.addAction(submit)
        present(alert, animated: true)
    }
    
    @IBAction func backToMenuButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
