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
            VStack(spacing:70){
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
        .scrollIndicators(.hidden)
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
                            print("Clicked")
                            
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
                                        .foregroundColor(Color.gray.opacity(0.5))
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                        )
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
            allFalse ? AnyView(Image(.headerBG).scaledToFit()): AnyView(Color.blue)
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
        
        ForEach(teams.indices, id: \.self) { index in
            List{
                HStack(spacing:20){
                    Text("\(index + 1)")
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width: 10)
                    
                    Circle()
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                    
                    Text(teams[index])
                        .foregroundColor(Color.white)
                        .frame(width: 50)
                }
                .listRowBackground(Color(hex: 0x101d6b))
                .listRowSeparator(.visible)
                .listRowSeparatorTint(Color.gray.opacity(0.5))
            }
            .toolbar {
                EditButton()
            }
            .environment(\.editMode, .constant(.active))
            .listStyle(.plain)
            .scrollDisabled(true)
            .frame(height:60)
        }
        .onMove(perform: { indices, newOffset in
                    move(indices: indices, newOffset: newOffset)
        })
        
    }
    
    func move(indices: IndexSet, newOffset: Int){
//        viewModel.newTeamsDict.move(fromOffsets: indices, toOffset: newOffset)
    }
    
}

// MARK: - Footer
struct GroupFooterDemo: View {
    var body: some View {
        HStack {
            Spacer()
            Button("View Group details") {
            }
            .tint(.yellow)
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
                Text("Predict the four best third - placed teams")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                Text("The four with the most points will progress to the knockout stages")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            }
            .padding(.all, 20)
            .background(Color.blue)
            PredictorListUI(viewModel: viewModel)
        }
    }
    
}

struct PredictorListUI: View{
    @ObservedObject var viewModel: GroupsViewModel
    
    var rowHeight: CGFloat? = 60
    var predictorArray = ["","","","","",""]
    
    var body: some View{
        List{
            Text("Kartikay")
        }
        .listStyle(.plain)
        .frame(height: 60)
    }
}


struct GroupsView_Previews_New: PreviewProvider {
    static var previews: some View {
        GroupsViewDemo(viewModel: GroupsViewModel())
    }
}
