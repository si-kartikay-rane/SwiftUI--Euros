//
//  UEFAGrpStageApp.swift
//  UEFAGrpStage
//
//  Created by Kartikay Rane on 31/05/24.
//

import SwiftUI

@main
struct UEFAGrpStageApp: App {
    var body: some Scene {
        WindowGroup {
            GroupsViewDemo(viewModel: GroupsViewModel())
        }
    }
}
