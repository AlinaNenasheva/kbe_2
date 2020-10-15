import UIKit

class ContractTableViewCell: UITableViewCell {

    @IBOutlet var dateOfSigning: UILabel!
    @IBOutlet var dateOfExpiring: UILabel!
    @IBOutlet var sumOfInsurance: UILabel!
    @IBOutlet var contractCompanyCode: UILabel!
    @IBOutlet var contractAgentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
