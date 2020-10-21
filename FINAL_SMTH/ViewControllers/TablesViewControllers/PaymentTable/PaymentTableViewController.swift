import UIKit

class PaymentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell", for: indexPath) as! PaymentTableViewCell
        cell.workerCategory.text = payments[indexPath.row].workerCategory
        cell.payment.text = String(payments[indexPath.row].sumOfPayment!)
        cell.paymentID.text = String(payments[indexPath.row].paymentID!)
        return cell
    }
    

    @IBOutlet var tableView: UITableView!
    let payments = DataBase.shared.getListOfPayments()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        let nib = UINib(nibName: "PaymentTableViewCell", bundle: nil)
         tableView.register(nib, forCellReuseIdentifier: "PaymentTableViewCell")
         tableView.delegate = self
         tableView.dataSource = self
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @objc func processSwipe(_ swipeGesture: UISwipeGestureRecognizer) {
         switch swipeGesture.direction {
         case .right:
            self.dismiss(animated: true)
         default:
             print("")
        }
    }
}
