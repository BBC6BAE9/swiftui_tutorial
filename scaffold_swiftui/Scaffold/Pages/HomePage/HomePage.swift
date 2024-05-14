//
//  HomeView.swift
//  Scaffold
//
//  Created by ihenry on 2024/5/6.
//

import SwiftUI

struct HomePage: View {
    @Environment(Router.self) private var router

    var body: some View {
        ScrollView {
            VStack{
                Color.red.frame(height: 400)
                Button("点击跳转个人中心") {
                    router.pushToActiveTab(route: .userSpacePage(mid: 123))
                }
                Color.blue.frame(height: 400)
            }
            .navigationTitle("首页")
        }
        
    }
}

#Preview {
    HomePage()
}
