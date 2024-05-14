//
//  Tab.swift
//  Scaffold
//
//  Created by ihenry on 2024/5/6.
//

import SwiftUI

extension Tab: CaseIterable{}

enum Tab:Int {

    case home // 首页
    case profile // 个人中心
    
    func desc() -> String {
        switch self {
        case .home:
            return "首页"
        case .profile:
            return "个人中心"
        }
    }
    
    func label() -> some View {
        switch self {
        case .home:
            return Label(self.desc(), systemImage: "hand.thumbsup.fill")
        case .profile:
            return Label(self.desc(), systemImage: "flame")
        }
    }
}

