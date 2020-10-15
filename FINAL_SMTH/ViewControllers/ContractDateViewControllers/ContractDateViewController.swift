import UIKit

class ContractDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickedCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContractDateTableViewCell", for: indexPath) as! ContractDateTableViewCell
        cell.companyName.text = pickedCompanies[indexPath.row].0
        cell.address.text = pickedCompanies[indexPath.row].1
        cell.currentDate.text = pickedCompanies[indexPath.row].2
        cell.idContract.text = pickedCompanies[indexPath.row].3
        cell.dateOfSigning.text = pickedCompanies[indexPath.row].4
        cell.dateOfExiting.text = pickedCompanies[indexPath.row].5
        return cell
    }
    

    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var companyCodeTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    typealias PickedCompany = (companyName: String, address: String, currentDate: String, idContract: String, dateOfSigning: String, dateOfExpiring: String)
    var currentDate: String?
    var pickedCompanies = [PickedCompany]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        let nib = UINib(nibName: "ContractDateTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContractDateTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func findButtonPressed(_ sender: Any) {
        if companyCodeTextField.text != "", currentDate != nil {
            pickedCompanies = DataBase.shared.showCompaniesList(companyCode: companyCodeTextField.text!, currentDate:
                currentDate!)
        }
        tableView.reloadData()
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        currentDate = formatter.string(from: datePicker.date)
    }
}
