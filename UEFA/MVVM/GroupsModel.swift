//
//  GroupsModel.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 18/06/24.
//

import Foundation
import SwiftUI

struct Group {
    var name: String
    var teams: [Team]
}

struct Team {
    var teamName : String
    var teamFlag : String
}

struct Predictor {
    var name : String
    var teamName : String
    var flag : String
    var isChecked : Bool
}
