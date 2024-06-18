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
    
    @Published var predictor : [String : String] = [
        "C" : "",
        "A" : "",
        "B" : "",
        "D" : "",
        "E" : "",
        "F" : ""
    ]
    
    @Published var groupTeamsDictNew : [Group]
    
    @Published var newTeamsDictNew: [Group]
    
    @Published var predictorNew : [Predictor]

    
    init() {
        self.groupTeamsDictNew = [
            Group(name: "C", teams: [
                Team(teamName: "ALB", teamFlag: "albania"),
                Team(teamName: "CRO", teamFlag: "croatia"),
                Team(teamName: "SUI", teamFlag: "switzerland"),
                Team(teamName: "DEN", teamFlag: "denmark")
            ]),
            Group(name: "A", teams: [
                Team(teamName: "GER", teamFlag: "germany"),
                Team(teamName: "FRA", teamFlag: "france"),
                Team(teamName: "POR", teamFlag: "portugal"),
                Team(teamName: "ITA", teamFlag: "italy")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "ESP", teamFlag: "spain"),
                Team(teamName: "ENG", teamFlag: "england"),
                Team(teamName: "BEL", teamFlag: "belgium"),
                Team(teamName: "NED", teamFlag: "netherlands")
            ]),
            Group(name: "D", teams: [
                Team(teamName: "POL", teamFlag: "poland"),
                Team(teamName: "UKR", teamFlag: "ukraine"),
                Team(teamName: "AUT", teamFlag: "austria"),
                Team(teamName: "TUR", teamFlag: "turkey")
            ]),
            Group(name: "E", teams: [
                Team(teamName: "ROM", teamFlag: "romania"),
                Team(teamName: "SCO", teamFlag: "scotland"),
                Team(teamName: "SVO", teamFlag: "slovenia"),
                Team(teamName: "CZE", teamFlag: "czechia")
            ]),
            Group(name: "F", teams: [
                Team(teamName: "HUN", teamFlag: "hungary"),
                Team(teamName: "GIA", teamFlag: "georgia"),
                Team(teamName: "SER", teamFlag: "serbia"),
                Team(teamName: "SLO", teamFlag: "slovakia")
            ])
        ]
        
        self.newTeamsDictNew = [
            Group(name: "C", teams: [
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: "")
            ]),
            Group(name: "A", teams: [
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: "")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: "")
            ]),
            Group(name: "D", teams: [
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: "")
            ]),
            Group(name: "E", teams: [
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: "")
            ]),
            Group(name: "F", teams: [
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: ""),
                Team(teamName: "", teamFlag: "")
            ])
        ]
        
        self.predictorNew = [
            Predictor(name: "A", teamName: "", flag: ""),
            Predictor(name: "B", teamName: "", flag: ""),
            Predictor(name: "C", teamName: "", flag: ""),
            Predictor(name: "D", teamName: "", flag: ""),
            Predictor(name: "E", teamName: "", flag: ""),
            Predictor(name: "F", teamName: "", flag: "")
        ]
    }
    
    
    //MARK: - Functions
    func indexMovedTeam(){
        for (groupKey, value) in newTeamsDict {
            if value.indices.contains(2) {
                predictor[groupKey] = value[2]
            }
        }
    }
    
    func addTeams(team: String, groupKey: String){
        if let firstEmptyIndex = newTeamsDict[groupKey]?.firstIndex(where: { $0.isEmpty }){
            if !newTeamsDict[groupKey]!.contains(team){
                newTeamsDict[groupKey]?[firstEmptyIndex] = team
            }
            indexMovedTeam()
        }
    }
    
    func move(team: String, indices: IndexSet, newOffset: Int) {
        var teamArray = newTeamsDict[team]
        teamArray?.move(fromOffsets: indices, toOffset: newOffset)
        newTeamsDict[team] = teamArray
        indexMovedTeam()
    }
}
