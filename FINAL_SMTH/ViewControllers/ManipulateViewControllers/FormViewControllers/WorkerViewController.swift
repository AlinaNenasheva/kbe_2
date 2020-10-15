import UIKit

class WorkerViewController: UIViewController {

    @IBOutlet weak var categoryRiskTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = "Ivanov Ivan Ivanovich"
        ageTextField.placeholder = "45"
        categoryRiskTextField.placeholder = "high/medium/low"
        companyCodeTextField.placeholder = "AAA"
    }
    
    @IBAction func addWorkerButtonPressed(_ sender: Any) {
        let worker: Worker = Worker()
        if let name = nameTextField.text {
            worker.name = name
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Full name\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if let age = Int(ageTextField.text!) {
            worker.age = age
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Age\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if let riskCategory = categoryRiskTextField.text {
            worker.riskCategory = riskCategory
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"RiskCategory\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        if let companyCode = companyCodeTextField.text {
             worker.companyCode = companyCode
         } else {
             let alert = UIAlertController(title: "Warning", message: "Fill the \"Company code\" field", preferredStyle: .alert)
             let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alert.addAction(ok)
             present(alert, animated: true, completion: nil)
         }
        if let _ = worker.name, let _ = worker.age, let _ = worker.riskCategory, let _ = worker.companyCode {
            DataBase.shared.addWorker(worker: worker)
        }
    }
    
    @IBAction func editWorkerButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "What worker do you want to change?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "WorkerID" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if let workerIDString = alert.textFields?.first?.text {
                let workerID: Int? = Int(workerIDString)!
                DataBase.shared.editWorker(workerID: workerID!, name: self.nameTextField.text, age: self.ageTextField.text, riskCategory: self.categoryRiskTextField.text)
            }
        }
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteWorkerButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "What worker do you want to delete?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "WorkerID" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if let workerIDString = alert.textFields?.first?.text {
                let workerID: Int? = Int(workerIDString)!
                DataBase.shared.deleteWorker(workerID: workerID!)
            }
        }
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backToMenuPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
