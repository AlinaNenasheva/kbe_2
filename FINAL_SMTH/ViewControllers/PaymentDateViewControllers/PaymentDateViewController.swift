import UIKit

class PaymentDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickedPayments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDateTableViewCell", for: indexPath) as! PaymentDateTableViewCell
        cell.currentDate.text = pickedPayments[indexPath.row].0
        cell.paymentID.text = pickedPayments[indexPath.row].1
        cell.workerCategory.text = pickedPayments[indexPath.row].2
        cell.sumOfPayments.text = pickedPayments[indexPath.row].3
        return cell
    }
    

    @IBOutlet var datePicker: UIDatePicker!
    var currentDate: String?
    @IBOutlet var tableView: UITableView!
    typealias PickedPayment = (currentDate: String, paymentID: String, workerCategory: String, sumOfPayments: String)
    var pickedPayments = [PickedPayment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        let nib = UINib(nibName: "PaymentDateTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PaymentDateTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func FindButtonPressed(_ sender: Any) {
        if currentDate != nil {
             pickedPayments = DataBase.shared.showPaymentsList(currentDate:
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
