//
//  BlockViewModel.swift
//  DemoPPP
//
//  Created by ihenry on 2024/5/14.
//

import SwiftUI

// 定义BViewModel，代表小模块
class BlockViewModel: Identifiable {
    var id = UUID()
    var title: String
    var subTitle: String
    
    init(block: Block) {
        self.title = block.title
        self.subTitle = block.subTitle
    }
}
