//
//  TabPage.swift
//  Bilibili
//
//  Created by huanghong on 2024/4/30.
//

import SwiftUI

struct TabPage<Content: View>: View {
    let tab: Tab
    let content: () -> Content

    var body: some View {
        NavStack(tab: self.tab) {
            self.content()
                .navigationDestination(for: Route.self, destination: { route in
                    switch route {
                    case .detail(let cid):
                        VideoDetailPage(cid: cid)
                    case .userSpacePage(let mid):
                        UpSpacePage(mid: mid)
                    case .userInfo:
                        UserInfoPage()
                    }
                })
        }
        .tabItem {
            tab.label()
        }
        .tag(self.tab)
    }
}

//#Preview {
//    TabView {
//        TabPage(title: "Test page", systemImage: "person", tab: .following) {
//            Text("Hello world")
//        }
//    }
//}

