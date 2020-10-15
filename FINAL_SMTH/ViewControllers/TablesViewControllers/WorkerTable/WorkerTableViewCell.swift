import UIKit

class WorkerTableViewCell: UITableViewCell {

    @IBOutlet var workerName: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var riskCategory: UILabel!
    @IBOutlet var companyCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
