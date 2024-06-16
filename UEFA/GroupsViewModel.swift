//
//  GroupsViewModel.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 11/06/24.
//

import Foundation
import SwiftUI
class GroupsViewModel: ObservableObject{
    @Published var groupTeamsDict : [String:[String]] = [
        "C" : ["SWE", "CRO", "SUI", "DEN"],
        "A" : ["GER", "FRA", "POR", "ITA"],
        "B" : ["ESP", "ENG", "BEL", "NED"],
        "D" : ["POL", "UKR", "AUT", "TUR"],
        "E" : ["WAL", "SCO", "RUS", "CZE"],
        "F" : ["HUN", "FIN", "NOR", "GRE"]
    ]
    
    @Published var newTeamsDict : [String:[String]] = [
        "C" : ["","","",""],
        "A" : ["","","",""],
        "B" : ["","","",""],
        "D" : ["","","",""],
        "E" : ["","","",""],
        "F" : ["","","",""]
    ]
    
    @Published var predictor : [String] = []
    
    //MARK: - Functions
    
    func addTeams(team: String, groupKey: String){
        if let firstEmptyIndex = newTeamsDict[groupKey]?.firstIndex(where: { $0.isEmpty }){
            if !newTeamsDict[groupKey]!.contains(team){
                newTeamsDict[groupKey]?[firstEmptyIndex] = team
            }
        }
        print(newTeamsDict)
    }
}
