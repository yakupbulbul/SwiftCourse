//
//  SuperMusicians.swift
//  MusicianClass
//
//  Created by yakup bülbül on 9.08.2022.
//

import Foundation


class SuperMusician : Musicians {
    func sing2 () {
        print("Enter Night")
    }
    
    
    override func sing() {
       super.sing()
        print("Exit life")
    }
}

