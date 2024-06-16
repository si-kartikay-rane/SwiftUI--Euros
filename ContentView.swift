//
//  ContentView.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 31/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var teams : [String] = ["Team1","Team2","Team3","Team4"]
    let data : [String] = ["A","B","C","D","E","F"]
    var body: some View {
        ScrollView{
            VStack{
                ForEach(data.indices, id: \.self){ index in
                    List{
                        VStack(alignment: .leading){
                            Text("Group \(Text(data[index]))")
                                .font(.system(size: 20))
                            Text("Drag Teams to reorder")
                                .font(.system(size: 10))
                        }
                        ForEach(teams.indices, id: \.self){ index in
                            Text("\(Text(teams[index]))")
                        }
                        .onMove(perform: { indices, newOffset in
                                    move(indices: indices, newOffset: newOffset)
                        })
                    }
                    .toolbar {
                        EditButton()
                    }
                    .environment(\.editMode, .constant(.active))
                    .frame(height: 250)
                }.background(Color.blue.edgesIgnoringSafeArea(.all))
            }
        }
        .background(Color.blue)
    }
    func move(indices: IndexSet, newOffset: Int){
        teams.move(fromOffsets: indices, toOffset: newOffset)
    }
}

struct UEFAList: PreviewProvider{
    static var previews: some View{
        ContentView()
            .listStyle(.inset)
    }
}
