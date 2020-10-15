import UIKit

class ContractTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractTableViewCell", for: indexPath) as! ContractTableViewCell
        cell.dateOfSigning.text = String((contracts[indexPath.row].dateOfSigning?.prefix(10))!)
        cell.dateOfExpiring.text = String( (contracts[indexPath.row].dateOfExpiring?.prefix(10))!)
        cell.sumOfInsurance.text = String(contracts[indexPath.row].sumOfInsurance!)
        cell.contractCompanyCode.text = contracts[indexPath.row].contractCompanyCode
        cell.contractAgentName.text = String(contracts[indexPath.row].contractAgentID!)
        return cell
    }
    

    @IBOutlet var tableView: UITableView!
    let contracts = DataBase.shared.getListOfContracts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        let nib = UINib(nibName: "ContractTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContractTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @objc func processSwipe(_ swipeGesture: UISwipeGestureRecognizer) {
         switch swipeGesture.direction {
         case .left:
             performSegue(withIdentifier: "showToPaymentTable", sender: self)
         case .right:
            self.dismiss(animated: true)
         default:
             print("")
        }
    }
}
