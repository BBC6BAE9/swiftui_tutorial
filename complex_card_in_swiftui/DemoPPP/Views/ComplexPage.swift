//
//  ComplexPage.swift
//  DemoPPP
//
//  Created by ihenry on 2024/5/14.
//

import SwiftUI

struct ComplexPage: View {
    
    @ObservedObject var viewModel: PageViewModel
    
    init() {
//        let bvm1 = BlockViewModel(title: "block1", subTitle: "swiftUI")
//        let bvm2 = BlockViewModel(title: "block2", subTitle: "swiftUI")
//        let bvm3 = BlockViewModel(title: "block3", subTitle: "swiftUI")
//        let avm1 = SectionViewModel(title: "Section1", bViewModels: [bvm1, bvm2])
//        let avm2 = SectionViewModel(title: "Section2", bViewModels: [bvm3])
        
//        self.viewModel = PageViewModel(aViewModels: [avm1, avm2])
        self.viewModel = PageViewModel()
    }
    
    var body: some View {
        List {
            ForEach(viewModel.sectionVMs) { aViewModel in
                SectionView(sectionVM: aViewModel)
            }
        }
    }
}

#Preview {
    ComplexPage()
}
