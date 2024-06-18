//
//  GroupsModel.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 18/06/24.
//

import Foundation

struct Group {
    let name: String
    let teams: [Team]
}

struct Team {
    let teamName : String
    let teamFlag : String
}

struct Predictor {
    let name : String
    let teamName : String
    let flag : String
}
