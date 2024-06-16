//
//  ListFile.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 13/06/24.
//

import SwiftUI

struct ListFile: View {
    var body: some View {
        VStack{
            
                VStack(alignment: .leading) {
                    HStack(spacing: 20) {
                       
                        
                        
                    }
                    
                    
                }
                .listStyle(.plain)
                .listRowBackground(Color(hex: 0x101d6b))
                .listRowSeparator(.visible)
                .listRowSeparatorTint(Color.gray.opacity(0.5))
            }
        }
    
}

#Preview {
    ListFile()
}
