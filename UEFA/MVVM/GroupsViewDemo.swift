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
        var groups = viewModel.groupTeamsDictNew
        VStack(spacing:0){
            // Navigation Bar
            navBar()
                .frame(height: 80)
                .ignoresSafeArea(.all,edges: .top)
            VStack(spacing:5){
                // Progress Bar
                ProgressView(value: Double(viewModel.progressViewCounter), total: 24)
                    .accentColor(.yellow)
                    .progressViewStyle(.linear)
                    .padding([.horizontal,.top],15)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(groups.indices) { i in
                            VStack(spacing: 0){
                                GroupHeaderDemo(index: i, viewModel: viewModel)
                                GroupListDemo(index: i,viewModel: viewModel)
                                GroupFooterDemo()
                            }
                            .cornerRadius(15)
                        }
                        .padding(.horizontal,15)
                    }
                    PredictorUIDemo(viewModel: viewModel)
                }
                .padding(.vertical,20)
            }
            .background(Color.scrollBg)
            .ignoresSafeArea(.all,edges: .vertical)
        }
    }
}


//MARK: - Navbar
struct navBar : View{
    var body: some View {
        ZStack {
            Image("headerBG")
                .resizable()
                .scaledToFill()
                .clipped()
            HStack{
                VStack{
                    Text("Groups")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.top,60)
                }
                Spacer()
            }
            .padding(.top,80)
            .padding(.leading,20)
        }
    }
}

// MARK: - Header
struct GroupHeaderDemo: View {
    
    var index: Int
    @State private var isEnabled: [Bool] = [true, true, true, true]
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        let groupKey = viewModel.groupTeamsDictNew[index].name
        let teams = viewModel.groupTeamsDictNew[index].teams
        
        let allFalse = self.isEnabled.allSatisfy { $0 == false }
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text("Group \(groupKey)")
                        .font(.system(size: 27))
                    if allFalse{
                        Text("Drag teams to reorder")
                            .font(.system(size: 15))
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 20)
                Spacer()
            }
            HStack(spacing: 45){
                ForEach(teams.indices, id: \.self) { i in
                    if !allFalse{
                        Button(action: {
                            viewModel.addTeams(team: teams[i], groupKey: groupKey)
                            self.isEnabled[i].toggle()
                            viewModel.progressViewCounter += 1
                        }) {
                            if isEnabled[i]{
                                VStack{
                                    Image(teams[i].teamFlag)
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                    
                                    Text(teams[i].teamName)
                                        .foregroundColor(.white)
                                }
                            }
                            else{
                                
                                VStack{
                                    Circle()
                                        .foregroundColor(Color.gray.opacity(0.7))
                                        .frame(width: 35, height: 35)
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
        let groupKey = viewModel.newTeamsDictNew[index].name
        let teams = viewModel.newTeamsDictNew[index].teams
        
        List {
            ForEach(teams.indices, id: \.self) { teamIndex in
                VStack(alignment: .leading, spacing: 13) {
                    HStack(spacing: 20) {
                        Text("\(teamIndex + 1)")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 10)
                        
                        Image(teams[teamIndex].teamFlag)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(25)
                            .overlay(
                                teams[teamIndex].teamFlag != "" ? RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2) : nil
                            )
                            .padding(.vertical,2.5)
                        
                        Text(teams[teamIndex].fullTeamName)
                            .foregroundColor(Color.white)
                        
                    }
                }
                .listRowBackground(Color(hex: 0x101d6b))
            }
            .onMove { indices, newOffset in
                viewModel.move(team: groupKey, indices: indices, newOffset: newOffset)
            }
            
        }
        .frame(height: 263)
        .environment(\.editMode, .constant(.active))
        .listStyle(.plain)
        
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

// MARK: - PredictorUI

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

// MARK: - PredictorUILists

struct PredictorListUI: View{
    @ObservedObject var viewModel: GroupsViewModel
    var rowHeight: CGFloat? = 55
    
    var body: some View{
        let items = viewModel.predictorNew
        let maxSelectionsReached = viewModel.checkedItemsCount >= 4
        VStack(spacing:0){
            ForEach(items.indices, id: \.self){i in
                VStack(spacing:0){
                    HStack(spacing:15){
                        Toggle(isOn: $viewModel.predictorNew[i].isChecked) {
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.7), lineWidth: 0.7)
                        )
                        .frame(width: 30)
                        .toggleStyle(CheckboxToggleStyle())
                        .disabled(items[i].flag == "" || (maxSelectionsReached && !items[i].isChecked))
                        .disabled(items[i].flag == "")
                        HStack(spacing: 15){
                            
                            Image("\(items[i].flag)")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(25)
                                .background(items[i].flag == "" ? Color.gray.opacity(0.5) : Color.clear).cornerRadius(25)
                                .overlay(
                                    items[i].flag != "" ? RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2) : nil
                                )
                            
                            Text("\(items[i].teamName)").foregroundColor(.white)
                            Spacer()
                            Text("Group \(items[i].name)").foregroundColor(.white).opacity(0.5)
                        }
                        
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,12)
                    if items[i].name != "F"{
                        Divider().frame(height: 0.5).background(Color.gray).opacity(0.3)
                    }
                }
                .frame(height: rowHeight)
                .background(viewModel.predictorNew[i].isChecked ? Color(hex: 0x101d6b) : Color(hex: 0x101d6b).opacity(0.4))
                .blur(radius: maxSelectionsReached && !items[i].isChecked ? 3.0 : 0)
            }
        }
    }
}

// MARK: - CheckBox Toggle struct
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "")
                .resizable()
                .foregroundColor(configuration.isOn ? .white : .white.opacity(0.5))
                .frame(width: 25, height: 25)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct GroupsView_Previews_New: PreviewProvider {
    static var previews: some View {
        GroupsViewDemo(viewModel: GroupsViewModel())
    }
}

