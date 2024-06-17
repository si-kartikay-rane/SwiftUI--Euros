//
//  GroupsViewDemo.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 11/06/24.
//
import SwiftUI

struct GroupsViewDemo: View {
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing:20){
                VStack(spacing: 20) {
                    ForEach(0..<viewModel.groupTeamsDict.keys.count, id: \.self) { i in
                        VStack(spacing: 0){
                            GroupHeaderDemo(index: i, viewModel: viewModel)
                            GroupListDemo(index: i,viewModel: viewModel)
                            GroupFooterDemo()
                        }
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .cornerRadius(15)
                    }
                }
                PredictorUIDemo(viewModel: viewModel)
            }
        }
    }
}

// MARK: - Header
struct GroupHeaderDemo: View {
    var index: Int
    @State private var isEnabled: [Bool] = [true, true, true, true]
    
    
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        let groupKey = viewModel.groupTeamsDict.keys.sorted()[index]
        let teams = viewModel.groupTeamsDict[groupKey] ?? []
        
        let allFalse = self.isEnabled.allSatisfy { $0 == false }
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text("Group \(groupKey)")
                        .font(.system(size: 30))
                    if allFalse{
                        Text("Drag teams to reorder")
                            .font(.system(size: 18))
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 20)
                Spacer()
            }
            HStack(spacing: 35){
                ForEach(teams.indices, id: \.self) { i in
                    if !allFalse{
                        Button(action: {
                            viewModel.addTeams(team: teams[i], groupKey: groupKey)
                            self.isEnabled[i].toggle()
                            
                        }) {
                            if isEnabled[i]{
                                VStack{
                                    Image("germany")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                    
                                    Text(teams[i])
                                        .foregroundColor(.white)
                                }
                            }
                            else{
                                
                                VStack{
                                    Circle()
                                        .foregroundColor(Color.gray.opacity(0.7))
                                        .frame(width: 40, height: 40)
                                    Text(" ")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        .disabled(!self.isEnabled[i])
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .background(
            HStack{
                allFalse ? Color.headingColour : Color.blue
                Spacer().frame(width: 0)
                allFalse ? AnyView(Image(.headerBG).resizable().scaledToFit()): AnyView(Color.blue)
            }
            
        )
    }
    
}

// MARK: - ListView
struct GroupListDemo: View {
    var index: Int
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        let groupKey = viewModel.groupTeamsDict.keys.sorted()[index]
        let teams = viewModel.newTeamsDict[groupKey] ?? []
        
        List {
            ForEach(teams.indices, id: \.self) { teamIndex in
                VStack(alignment: .leading, spacing: 13) {
                    HStack(spacing: 20) {
                        Text("\(teamIndex + 1)")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 10)
                        
                        Circle()
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 40, height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                            )
                        
                        Text(teams[teamIndex])
                            .foregroundColor(Color.white)
                            .frame(width: 50)
                    }
                }
                .listRowBackground(Color(hex: 0x101d6b))
            }
            .onMove { indices, newOffset in
                move(team: groupKey, indices: indices, newOffset: newOffset)
                print(viewModel.newTeamsDict)
                print(viewModel.predictor)
            }
            
        }
        .environment(\.editMode, .constant(.active))
        .listStyle(.plain)
        .frame(height: 263)
        
    }
    
    func move(team: String, indices: IndexSet, newOffset: Int) {
        var teamArray = viewModel.newTeamsDict[team]
        teamArray?.move(fromOffsets: indices, toOffset: newOffset)
        viewModel.newTeamsDict[team] = teamArray
        viewModel.indexMovedTeam()
    }
}



// MARK: - Footer
struct GroupFooterDemo: View {
    var body: some View {
        HStack {
            Spacer()
            Button("View Group details") {
            }
            .foregroundColor(.yellow)
            Spacer()
        }
        .padding()
        .background(Color(hex: 0x112f81))
    }
}



struct PredictorUIDemo: View{
    
    
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        VStack(spacing:0){
            VStack(spacing:0){
                HStack{
                    Spacer()
                    VStack(alignment: .leading,spacing: 10){
                        Text("Predict the four best third - placed teams")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                        Text("The four with the most points will progress to the knockout stage.")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            .padding([.top,.bottom])
            .background(Color.blue)
            
            PredictorListUI(viewModel: viewModel)
        }
        .cornerRadius(10)
        .padding(15)
        
    }
    
}

struct PredictorListUI: View{
    @ObservedObject var viewModel: GroupsViewModel
    
    var rowHeight: CGFloat? = 60
    @State private var isChecked: Bool = false
    
    var body: some View{
        
        ForEach(viewModel.predictor.keys.sorted(), id: \.self){i in
            List{
                HStack(spacing:20){
                    Toggle(isOn: $isChecked) {
                    }
                    .frame(width: 30)
                    .toggleStyle(CheckboxToggleStyle())
                    HStack(spacing: 15){
                        Circle()
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 35, height: 35)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                            )
                        Text("\(viewModel.predictor[i] ?? "")").foregroundColor(.white)
                        Spacer()
                        Text("Group \(i)").foregroundColor(.white).opacity(0.5)
                    }
                    
                }
                .listRowBackground(Color(hex: 0x101d6b))
                .padding(2)
            }
            
        }
        .listStyle(.plain)
        .frame(height: rowHeight)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .foregroundColor(configuration.isOn ? .white : .white.opacity(0.5))
                .frame(width: 35, height: 35)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct GroupsView_Previews_New: PreviewProvider {
    static var previews: some View {
        GroupsViewDemo(viewModel: GroupsViewModel())
    }
}

