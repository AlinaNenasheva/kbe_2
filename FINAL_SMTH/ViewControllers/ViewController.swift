import UIKit
import SQLite
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DataBase.shared.createAgentTable()
//        DataBase.shared.createCompanyTable()
//        DataBase.shared.createContractTable()
//        DataBase.shared.createWorkerTable()
//        DataBase.shared.createPaymentTable()
//        DataBase.shared.showAllTables()
    }
    
    @IBAction func currentCompanyDateButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToCompanyDate", sender: self)
    }
    
    @IBAction func manipulateTablesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToManipulate", sender: self)
    }
    
    @IBAction func showTablesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToTables", sender: self)
    }
    
    @IBAction func currentAgentDateButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToContractDate", sender: self)
    }
    
    @IBAction func currentDatePaymentButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToPayment", sender: self)
    }
    
}

