import UIKit

class AgentDateTableViewCell: UITableViewCell {

    @IBOutlet var currentDate: UILabel!
    @IBOutlet var agentName: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var insuranceCompany: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
