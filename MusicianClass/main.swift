//
//  main.swift
//  MusicianClass
//
//  Created by yakup bülbül on 9.08.2022.
//

import Foundation

let james = Musicians(nameInit: "James", ageInit: 50, instrumnetInit: "Guitar", typeInit:  .Vocalist)


print(james.name)
// Property

james.sing()


let kirk = SuperMusician(nameInit: "Kirk", ageInit: 55, instrumnetInit: "Guitar", typeInit: .LeadGuitar)

//kirk.sing2()

kirk.sing()
