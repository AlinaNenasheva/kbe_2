import UIKit
import SQLite
class ViewController: UIViewController {
    @IBOutlet weak var showTablesButton: UIButton!
    @IBOutlet weak var manipulateTablesButton: UIButton!
    @IBOutlet weak var specialTaskOneButton: UIButton!
    @IBOutlet weak var specialTaskTwoButton: UIButton!
    @IBOutlet weak var specialTaskThreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTablesButton.layer.cornerRadius = 10
        manipulateTablesButton.layer.cornerRadius = 10
        specialTaskOneButton.layer.cornerRadius = 10
        specialTaskTwoButton.layer.cornerRadius = 10
        specialTaskThreeButton.layer.cornerRadius = 10
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

