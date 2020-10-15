import UIKit

class AgentViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passportTextFiekd: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var insuranceCompanyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameTextField.placeholder = "Ivanov Ivan Ivanovich"
        passportTextFiekd.placeholder = "XXYYYYYYYY"
        phoneTextField.placeholder = "+375-()-XXX-XXXX"
        insuranceCompanyTextField.placeholder = "Company name"
    }
    
    @IBAction func addAgentButtonPressed(_ sender: Any) {
        let agent: Agent = Agent()
        if fullNameTextField.text != "" {
            agent.name = fullNameTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Full name\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if passportTextFiekd.text != "" {
            agent.passport = passportTextFiekd.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Passport\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if phoneTextField.text != "" {
            agent.phone = phoneTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Phone\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if insuranceCompanyTextField.text != "" {
            agent.insuranceCompany = insuranceCompanyTextField.text
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Insurance company\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if let _ = agent.name, let _ = agent.passport, let _ = agent.phone, let _ = agent.insuranceCompany {
            DataBase.shared.addAgent(agent: agent)
        }
    }
    
    @IBAction func editAgentButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "What agent do you want to change?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "AgentID" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if let agentIDString = alert.textFields?.first?.text {
                let agentID: Int? = Int(agentIDString)!
                DataBase.shared.editAgent(agentID: agentID!, name: self.fullNameTextField.text, passport: self.passportTextFiekd.text, phone: self.phoneTextField.text, insuranceCompany: self.insuranceCompanyTextField.text)
            }
        }
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteAgentButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "What agent do you want to delete?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "AgentID" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if let agentIDString = alert.textFields?.first?.text {
                let agentID: Int? = Int(agentIDString)!
                DataBase.shared.deleteAgent(agentID: agentID!)
            }
        }
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToMenuButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
