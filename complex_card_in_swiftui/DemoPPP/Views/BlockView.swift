//
//  BlockView.swift
//  DemoPPP
//
//  Created by ihenry on 2024/5/14.
//

import SwiftUI

struct BlockView: View {
    var blockVM: BlockViewModel
    
    var body: some View {
        HStack {
            Text(blockVM.title)
                .font(.subheadline)
            Spacer()
            Text(blockVM.subTitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .background(.purple)
    }
}
