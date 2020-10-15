import UIKit

class CompanyDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickedAgents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentDateTableViewCell", for: indexPath) as! AgentDateTableViewCell
        cell.currentDate.text = pickedAgents[indexPath.row].0
        cell.agentName.text = pickedAgents[indexPath.row].1
        cell.phone.text = pickedAgents[indexPath.row].2
        cell.insuranceCompany.text = pickedAgents[indexPath.row].3
        return cell
    }

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var companyCodeTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var currentDate: String?
    typealias PickedAgent = (currentDate: String, agentName: String, phone: String, insuranceCompany: String)
    var pickedAgents = [PickedAgent]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        let nib = UINib(nibName: "AgentDateTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AgentDateTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func findButtonPressed(_ sender: Any) {
        if companyCodeTextField.text != "", currentDate != nil {
            pickedAgents = DataBase.shared.showAgentsList(companyCode: companyCodeTextField.text!, currentDate:
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
