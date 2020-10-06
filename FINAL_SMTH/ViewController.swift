//
//  ViewController.swift
//  FINAL_SMTH
//
//  Created by Алина Ненашева on 10/5/20.
//  Copyright © 2020 Алина Ненашева. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.shared.createWorkerTable()
        DataBase.shared.createAgentTable()
    }

  
    
    
    @IBAction func manipulateTablesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showToManipulate", sender: self)
    }
    
}

