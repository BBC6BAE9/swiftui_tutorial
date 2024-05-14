//
//  Router.swift
//  Bilibili
//
//  Created by huanghong on 2024/4/30.
//

import SwiftUI

// 使用字符串做路由
enum Route: Hashable {
    // 视频详情页
    case detail(cid: Int)

    // 个人空间
    case userSpacePage(mid: Int)
    
    // 个人信息页面
    case userInfo
}

@Observable final class Router: Sendable {
    var tab: Tab = .home
    var path: [Tab: [Route]] = [:]
    var tabBinding: Binding<Tab> {
        Binding(get: { self.tab }, set: { self.tab = $0 })
    }

    var bufferedWindow: String?

    func pathForActiveTab() -> [Route] {
        self.path(for: self.tab)
    }

    func path(for tab: Tab) -> [Route] {
        if let path = self.path[tab] {
            return path
        } else {
            let array: [Route] = []
            self.path[tab] = array
            return array
        }
    }

    func pathBinding(for tab: Tab) -> Binding<[Route]> {
        return Binding(get: { self.path(for: tab) }, set: { self.path[tab] = $0 })
    }

    func pushToActiveTab(route: Route) {
        // Make sure path exists
        let _ = self.path(for: self.tab)

        self.path[self.tab]?.append(route)
    }
}
