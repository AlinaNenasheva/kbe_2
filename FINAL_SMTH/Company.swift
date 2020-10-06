//
//  Company.swift
//  FINAL_SMTH
//
//  Created by Алина Ненашева on 10/5/20.
//  Copyright © 2020 Алина Ненашева. All rights reserved.
//

import Foundation

class Company{
    var code: String
    var name: String
    var abbreviation: String
    var address: String
    var bankID: Int
    var specialization: String
    
    init (code: String ,name: String, abbreviation: String, address: String, bankID: Int, specialization: String) {
        self.code = code
        self.name = name
        self.abbreviation = abbreviation
        self.address = address
        self.bankID = bankID
        self.specialization = specialization
    }

}
