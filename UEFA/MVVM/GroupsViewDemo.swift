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
        VStack(spacing:0){
                navBar()
                .frame(height: 80)
                .ignoresSafeArea(.all,edges: .top)
                
                    VStack(spacing:20){
                        ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.groupTeamsDictNew.indices) { i in
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
                    .background(Color.scrollBg)
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
                        
                        Text(teams[teamIndex].teamName)
                            .foregroundColor(Color.white)
                            .frame(width: 50)
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
        
        ForEach(viewModel.predictorNew.indices, id: \.self){i in
            List{
                HStack(spacing:20){
                        Toggle(isOn: $viewModel.predictorNew[i].isChecked) {
                        }
                        .frame(width: 30)
                        .toggleStyle(CheckboxToggleStyle())
                        .disabled(viewModel.predictorNew[i].flag == "")
                        HStack(spacing: 15){
                            
                            Image("\(viewModel.predictorNew[i].flag)")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(25)
                                .background(viewModel.predictorNew[i].flag == "" ? Color.gray.opacity(0.5) : Color.clear).cornerRadius(25)
                                .overlay(
                                    viewModel.predictorNew[i].flag != "" ? RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2) : nil
                                )
                            
                            Text("\(viewModel.predictorNew[i].teamName)").foregroundColor(.white)
                            Spacer()
                            Text("Group \(viewModel.predictorNew[i].name)").foregroundColor(.white).opacity(0.5)
                        }

                }
                .listRowBackground(Color(hex: 0x101d6b))
                .padding(5)
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

