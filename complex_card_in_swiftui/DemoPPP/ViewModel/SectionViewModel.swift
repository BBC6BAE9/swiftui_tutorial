//
//  SectionViewModel.swift
//  DemoPPP
//
//  Created by ihenry on 2024/5/14.
//

import SwiftUI

class SectionViewModel: Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    @Published var blockVMs: [BlockViewModel]
    
    init(section: Section) {
        self.title = section.title
        var tempBlockVMS: [BlockViewModel] = []
        for block in section.blocks {
            tempBlockVMS.append(BlockViewModel(block: block))
        }
        self.blockVMs = tempBlockVMS // 将初始化放到最后
    }
    
    func removeLast(){
        if (!blockVMs.isEmpty){
            blockVMs.removeLast()
        }
    }
}
