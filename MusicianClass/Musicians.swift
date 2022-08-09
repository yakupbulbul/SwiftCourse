//
//  Musicians.swift
//  MusicianClass
//
//  Created by yakup bülbül on 9.08.2022.
//

import Foundation

enum MusiciansType {
    case LeadGuitar
    case Vocalist
    case Drummer
    case Bassist
    case Violenist
}

class Musicians {
    var name : String
    var age : Int
    var instrument : String
    var type : MusiciansType
    //Initilizater   // Constucator
    init (nameInit : String, ageInit : Int, instrumnetInit : String, typeInit: MusiciansType) {
        name = nameInit
        age = ageInit
        instrument = instrumnetInit
        type = typeInit
    }
    
    func sing () {
        print("Nothing Else Matter")
    }
}

