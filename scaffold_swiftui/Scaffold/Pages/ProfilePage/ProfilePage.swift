//
//  ProfilePage.swift
//  Scaffold
//
//  Created by ihenry on 2024/5/6.
//

import SwiftUI

struct ProfilePage: View {
    @Environment(Router.self) private var router

    var body: some View {
        Text("我的")
        Button("点击跳转个人中心") {
            router.pushToActiveTab(route: .userSpacePage(mid: 123))
        }
        .navigationTitle("我的")
    }
}

#Preview {
    ProfilePage()
}
