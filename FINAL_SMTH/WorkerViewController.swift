//
//  WorkerViewController.swift
//  FINAL_SMTH
//
//  Created by Алина Ненашева on 10/5/20.
//  Copyright © 2020 Алина Ненашева. All rights reserved.
//

import UIKit

class WorkerViewController: UIViewController {

    @IBOutlet weak var categoryRiskTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var worker: Worker = Worker(name: "", age: 0, riskCategory: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = "Ivanov Ivan Ivanovich"
        ageTextField.placeholder = "45"
        categoryRiskTextField.placeholder = "high/medium/low"
    }
    @IBAction func addWorkerButtonPressed(_ sender: Any) {
        if let name = nameTextField.text {
            worker.name = name
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Full name\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        if let age = Int(ageTextField.text!) {
            worker.age = age
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"Age\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        if let riskCategory = categoryRiskTextField.text {
            worker.riskCategory = riskCategory
        } else {
            let alert = UIAlertController(title: "Warning", message: "Fill the \"RiskCategory\" field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        if let name = nameTextField.text, let age = Int(ageTextField.text!), let riskCategory = categoryRiskTextField.text {
            DataBase.shared.addWorker(worker: worker)
        }
    }
    
    @IBAction func editWorkerButtonPressed(_ sender: Any) {
        var workerID: Int?
        let alert = UIAlertController(title: nil, message: "What worker do you want to change?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "WorkerID" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if let workerIDString = alert.textFields?.first?.text {
                workerID = Int(workerIDString)!
            }
        }
        alert.addAction(submit)
        self.present(alert, animated: true, completion: nil)
        DataBase.shared.editWorker(workerID: workerID!, name: nameTextField.text, age: ageTextField.text, riskCategory: categoryRiskTextField.text)
    }
    
    @IBAction func deleteWorkerButtonPressed(_ sender: Any) {
        var workerID: Int?
        let alert = UIAlertController(title: nil, message: "What worker do you want to delete?", preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "WorkerID" }
        let cancel = UIAlertAction(title: "Canсel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let submit = UIAlertAction(title: "Submit", style: .default) { (_) in
            if let workerIDString = alert.textFields?.first?.text {
                workerID = Int(workerIDString)!
            }
        }
        alert.addAction(submit)
        self.present(alert, animated: true, completion: nil)
        DataBase.shared.deleteWorker(workerID: workerID!)
    }
    
    @IBAction func backToMenuPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
