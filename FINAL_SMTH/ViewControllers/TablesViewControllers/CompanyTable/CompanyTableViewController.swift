import UIKit

class CompanyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyTableViewCell", for: indexPath) as! CompanyTableViewCell
        cell.code.text = companies[indexPath.row].code
        cell.fullName.text = companies[indexPath.row].name
        cell.shortName.text = companies[indexPath.row].abbreviation
        cell.address.text = companies[indexPath.row].address
        cell.bankID.text = String(companies[indexPath.row].bankID!)
        cell.specialization.text = companies[indexPath.row].specialization
        return cell

    }
    

    @IBOutlet var tableView: UITableView!
    let companies = DataBase.shared.getListOfCompanies()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        
        view.addGestureRecognizer(rightSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        let nib = UINib(nibName: "CompanyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CompanyTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func processSwipe(_ swipeGesture: UISwipeGestureRecognizer) {
         switch swipeGesture.direction {
         case .left:
             performSegue(withIdentifier: "showToContractTable", sender: self)
         case .right:
            self.dismiss(animated: true)
         default:
             print("")
         }
    }
}
