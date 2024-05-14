//
//  PageViewModel.swift
//  DemoPPP
//
//  Created by ihenry on 2024/5/14.
//

import Foundation
import SwiftUI

class PageViewModel: ObservableObject {
    
    @Published var sectionVMs: [SectionViewModel]
    
    init() {
        let sections = Self.previewData()
        var tempSectionVMS: [SectionViewModel] = []
        for section in sections {
            tempSectionVMS.append(SectionViewModel(section: section))
        }
        self.sectionVMs = tempSectionVMS
    }
    
    
    static func previewData() -> [Section] {
        let url = Bundle.main.url(forResource: "demo", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let sections = try decoder.decode([Section].self, from: data)
            return sections
        } catch {
            return []
        }
        return []
    }
}
