import UIKit

class AgentTableViewCell: UITableViewCell {

    @IBOutlet var agentName: UILabel!
    @IBOutlet var passport: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var insuranceCompany: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
