//
//  UpSpacePage.swift
//  Scaffold
//
//  Created by ihenry on 2024/5/6.
//

import SwiftUI

struct UpSpacePage: View {
    @Environment(Router.self) private var router

    var mid:Int
    
    var body: some View {
        Text("我是个人空间")
        Button("跳转到个人空间") {
            router.pushToActiveTab(route: .userInfo)
        }
    }
}

#Preview {
    UpSpacePage(mid: 123)
}
