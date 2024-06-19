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
    @Published var progressViewCounter : Int = 0
    
    init(){
        self.groupTeamsDictNew = [
            Group(name: "A", teams: [
                Team(teamName: "ALB", fullTeamName: "Albania", teamFlag: "albania"),
                Team(teamName: "CRO", fullTeamName: "Croatia", teamFlag: "croatia"),
                Team(teamName: "SUI", fullTeamName: "Switzerland", teamFlag: "switzerland"),
                Team(teamName: "DEN", fullTeamName: "Denmark", teamFlag: "denmark")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "GER", fullTeamName: "Germany", teamFlag: "germany"),
                Team(teamName: "FRA", fullTeamName: "France", teamFlag: "france"),
                Team(teamName: "POR", fullTeamName: "Portugal", teamFlag: "portugal"),
                Team(teamName: "ITA", fullTeamName: "Italy", teamFlag: "italy")
            ]),
            Group(name: "C", teams: [
                Team(teamName: "ESP", fullTeamName: "Spain", teamFlag: "spain"),
                Team(teamName: "ENG", fullTeamName: "England", teamFlag: "england"),
                Team(teamName: "BEL", fullTeamName: "Belgium", teamFlag: "belgium"),
                Team(teamName: "NED", fullTeamName: "Netherlands", teamFlag: "netherlands")
            ]),
            Group(name: "D", teams: [
                Team(teamName: "POL", fullTeamName: "Poland", teamFlag: "poland"),
                Team(teamName: "UKR", fullTeamName: "Ukraine", teamFlag: "ukraine"),
                Team(teamName: "AUT", fullTeamName: "Austria", teamFlag: "austria"),
                Team(teamName: "TUR", fullTeamName: "Turkey", teamFlag: "turkey")
            ]),
            Group(name: "E", teams: [
                Team(teamName: "ROM", fullTeamName: "Romaina", teamFlag: "romaina"),
                Team(teamName: "SCO", fullTeamName: "Scotland", teamFlag: "scotland"),
                Team(teamName: "SVO", fullTeamName: "Slovenia", teamFlag: "slovenia"),
                Team(teamName: "CZE", fullTeamName: "Czechia", teamFlag: "czechia")
            ]),
            Group(name: "F", teams: [
                Team(teamName: "HUN", fullTeamName: "Hungary", teamFlag: "hungary"),
                Team(teamName: "GIA", fullTeamName: "Georgia", teamFlag: "georgia"),
                Team(teamName: "SER", fullTeamName: "Serbia", teamFlag: "serbia"),
                Team(teamName: "SLO", fullTeamName: "Slovakia", teamFlag: "slovakia")
            ])
        ]
        
        self.newTeamsDictNew = [
            Group(name: "A", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "C", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "D", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "E", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "F", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
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
                predictorNew[index].teamName = group.teams[2].fullTeamName
                predictorNew[index].flag = group.teams[2].teamFlag
            }
        }
    }
    
    var checkedItemsCount: Int {
        predictorNew.filter { $0.isChecked }.count
    }
    
    func addTeams(team: Team, groupKey: String) {
        
        if let groupIndex = newTeamsDictNew.firstIndex(where: { $0.name == groupKey }) {
            if let firstEmptyIndex = newTeamsDictNew[groupIndex].teams.firstIndex(where: { $0.teamName.isEmpty && $0.teamFlag.isEmpty }) {
                if !newTeamsDictNew[groupIndex].teams.contains(where: { $0.teamName == team.teamName && $0.teamFlag == team.teamFlag }) {
                    newTeamsDictNew[groupIndex].teams[firstEmptyIndex] = team
                    indexMovedTeam()
                }
            }
        }
    }
    
    func move(team: String, indices: IndexSet, newOffset: Int) {
        guard let index = newTeamsDictNew.firstIndex(where: { $0.name == team }) else {
            return
        }
        
        var group = newTeamsDictNew[index]
        withAnimation {
            group.teams.move(fromOffsets: indices, toOffset: newOffset)
        }
        newTeamsDictNew[index] = group
        
        indexMovedTeam()
    }
}
