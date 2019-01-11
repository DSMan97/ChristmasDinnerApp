//
//  Participants.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 9/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import Foundation
import RealmSwift

class Participants: Object{
    @objc dynamic var name = ""//name
    
    @objc dynamic var assistDate = Date() //Date of assintan
    @objc dynamic var paidState = false //Paid state
    
    
    convenience init( name: String, assistDate: Date, paidState: Bool){
        self.init()
        
        self.name = name
        self.assistDate = assistDate
        self.paidState = paidState
    }
    override static func primaryKey() -> String? { //set id as Primary Key
        return "name"
    }
    
    func participantModel() -> Participant {
        let model = Participant()
       
        model.name = name
        model.assistDate = assistDate
        model.paidState = paidState
        return model
    }
}


