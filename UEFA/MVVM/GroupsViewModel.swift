//
//  GroupsViewModel.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 11/06/24.
//

import Foundation
import SwiftUI
class GroupsViewModel: ObservableObject{
    @Published var groupTeamsDictNew : [Group]
    @Published var newTeamsDictNew: [Group]
    @Published var predictorNew : [Predictor]

    
    init() {
        self.groupTeamsDictNew = [
            Group(name: "A", teams: [
                Team(teamName: "ALB", teamFlag: "albania"),
                Team(teamName: "CRO", teamFlag: "croatia"),
                Team(teamName: "SUI", teamFlag: "switzerland"),
                Team(teamName: "DEN", teamFlag: "denmark")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "GER", teamFlag: "germany"),
                Team(teamName: "FRA", teamFlag: "france"),
                Team(teamName: "POR", teamFlag: "portugal"),
                Team(teamName: "ITA", teamFlag: "italy")
            ]),
            Group(name: "C", teams: [
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
                Team(teamName: "ROM", teamFlag: "romaina"),
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
            Group(name: "C", teams: [
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
            Predictor(name: "A", teamName: "", flag: "", isChecked: false),
            Predictor(name: "B", teamName: "", flag: "", isChecked: false),
            Predictor(name: "C", teamName: "", flag: "", isChecked: false),
            Predictor(name: "D", teamName: "", flag: "", isChecked: false),
            Predictor(name: "E", teamName: "", flag: "", isChecked: false),
            Predictor(name: "F", teamName: "", flag: "", isChecked: false)
        ]
    }
    
    
    //MARK: - Functions
    func indexMovedTeam(){
        for (index, group) in newTeamsDictNew.enumerated() {
            if group.teams.indices.contains(2) {
                predictorNew[index].teamName = group.teams[2].teamName
                predictorNew[index].flag = group.teams[2].teamFlag
            }
        }
    }
    
    func addTeams(team: Team, groupKey: String) {
        guard let groupIndex = newTeamsDictNew.firstIndex(where: { $0.name == groupKey }) else {
            return
        }
        if let firstEmptyIndex = newTeamsDictNew[groupIndex].teams.firstIndex(where: { $0.teamName.isEmpty && $0.teamFlag.isEmpty }) {
            if !newTeamsDictNew[groupIndex].teams.contains(where: { $0.teamName == team.teamName && $0.teamFlag == team.teamFlag }) {
                newTeamsDictNew[groupIndex].teams[firstEmptyIndex] = team
                indexMovedTeam()
            }
        }
    }
    
    func move(team: String, indices: IndexSet, newOffset: Int) {
//        guard var group = newTeamsDictNew.first(where: { $0.name == team }) else {
//            return
//        }
        if var group = newTeamsDictNew.first(where: { $0.name == team }) {
            group.teams.move(fromOffsets: indices, toOffset: newOffset)
            if let index = newTeamsDictNew.firstIndex(where: { $0.name == team }) {
                newTeamsDictNew[index] = group
            }
            indexMovedTeam()
        }
    }
}
