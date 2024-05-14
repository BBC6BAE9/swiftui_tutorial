//
//  ScaffoldApp.swift
//  Scaffold
//
//  Created by ihenry on 2024/5/6.
//

import SwiftUI

@main
struct ScaffoldApp: App {
    @State var router: Router = .init()
    private static let scheme = "txvideo" // 协议头
    private static let host = "v.qq.com" // 域名
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(self.router)
                .onOpenURL(perform: { url in
                    // 判断外链的协议头和域名是否符合约定
                    guard url.scheme == ScaffoldApp.scheme,
                          url.host() == ScaffoldApp.host else {
                        return
                    }
                    let path = url.path()
                    // 详情页面的路由处理
                    if path == "detail" {
                        if let params = url.params(),
                           let cid = params["cid"],
                            let cidInt = Int(cid)
                        {
                            router.pushToActiveTab(route: .detail(cid: cidInt))
                        }
                    }
                })
        }
    }
}
