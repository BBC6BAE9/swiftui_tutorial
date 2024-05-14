//
//  SectionView.swift
//  DemoPPP
//
//  Created by ihenry on 2024/5/14.
//

import SwiftUI

struct SectionView: View {
    @ObservedObject var sectionVM: SectionViewModel
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(sectionVM.title)
                    .font(.headline)
                ForEach(sectionVM.blockVMs) { bViewModel in
                    BlockView(blockVM: bViewModel)
                }
                Button(action: {
                    sectionVM.removeLast()
                }, label: {
                    Text("click to remove block")
                })
            }
            Spacer()
        }
        .background(.red)
    }
}
