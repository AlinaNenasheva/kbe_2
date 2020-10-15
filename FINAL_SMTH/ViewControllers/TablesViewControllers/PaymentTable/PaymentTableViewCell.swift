import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet var workerCategory: UILabel!
    @IBOutlet var payment: UILabel!
    @IBOutlet var contractID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
