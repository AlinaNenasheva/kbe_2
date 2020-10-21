import UIKit

class PaymentDateTableViewCell: UITableViewCell {

    @IBOutlet var currentDate: UILabel!
    @IBOutlet var paymentID: UILabel!
    @IBOutlet var workerCategory: UILabel!
    @IBOutlet var sumOfPayments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
