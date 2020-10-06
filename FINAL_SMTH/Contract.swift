//
//  Contract.swift
//  FINAL_SMTH
//
//  Created by Алина Ненашева on 10/5/20.
//  Copyright © 2020 Алина Ненашева. All rights reserved.
//

import Foundation

class Contract{
    var dateOfSigning: Date
    var dateOfExpiring: Date
    var sumOfInsurance: Int

    init(dateOfSigning: Date, dateOfExpiring: Date, sumOfInsurance: Int){
        self.dateOfExpiring = dateOfExpiring
        self.dateOfSigning = dateOfSigning
        self.sumOfInsurance = sumOfInsurance
    }
}
