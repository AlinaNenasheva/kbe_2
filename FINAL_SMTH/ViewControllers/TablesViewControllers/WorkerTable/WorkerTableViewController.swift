import UIKit

class WorkerTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkerTableViewCell", for: indexPath) as! WorkerTableViewCell
        cell.workerName.text = workers[indexPath.row].name
        cell.age.text = String(workers[indexPath.row].age!)
        cell.riskCategory.text = workers[indexPath.row].riskCategory
        cell.companyCode.text = workers[indexPath.row].companyCode
        return cell
    }
    

    @IBOutlet var tableView: UITableView!
    let workers = DataBase.shared.getListOfWorkers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(rightSwipeGesture)
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        let nib = UINib(nibName: "WorkerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "WorkerTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func processSwipe(_ swipeGesture: UISwipeGestureRecognizer) {
         switch swipeGesture.direction {
         case .left:
             performSegue(withIdentifier: "showToAgentTable", sender: self)
         case .right:
            self.dismiss(animated: true)
         default:
             print("")
         }
     }
}
