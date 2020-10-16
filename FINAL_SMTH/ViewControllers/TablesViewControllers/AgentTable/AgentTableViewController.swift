import UIKit

class AgentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentTableViewCell", for: indexPath) as! AgentTableViewCell
        cell.agentName.text = "\(agents[indexPath.row].agentID!) \(agents[indexPath.row].name!)"
        cell.passport.text = agents[indexPath.row].passport
        cell.phone.text = agents[indexPath.row].phone
        cell.insuranceCompany.text = agents[indexPath.row].insuranceCompany
        return cell
    }

    @IBOutlet var tableView: UITableView!
    let agents = DataBase.shared.getListOfAgents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        
        view.addGestureRecognizer(rightSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        leftSwipeGesture.direction = .left
        view.addGestureRecognizer(leftSwipeGesture)
        let nib = UINib(nibName: "AgentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AgentTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func processSwipe(_ swipeGesture: UISwipeGestureRecognizer) {
         switch swipeGesture.direction {
         case .left:
             performSegue(withIdentifier: "showToCompanyTable", sender: self)
         case .right:
            self.dismiss(animated: true)
         default:
             print("")
        }
    }
}
