import UIKit

class ManipulateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func manipulateWorkerButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToWorker", sender: self)
    }
    
    @IBAction func manipulateCompanyButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToCompanies", sender: self)
    }
    @IBAction func backToMenuButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func manipulateAgentButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToAgent", sender: self)
    }
}
