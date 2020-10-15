import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet var code: UILabel!
    @IBOutlet var fullName: UILabel!
    @IBOutlet var shortName: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var bankID: UILabel!
    @IBOutlet var specialization: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
