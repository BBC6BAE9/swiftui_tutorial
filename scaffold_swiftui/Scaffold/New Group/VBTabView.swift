//
//  TabView.swift
//  Bilibili
//
//  Created by huanghong on 2024/4/30.
//

import SwiftUI

struct VBTabView: View {
    @Environment(Router.self) private var router
    
    /// 推荐
    var feedPage: some View = LazyView(HomePage())
    
    /// 我的
    var profilePage: some View = LazyView(ProfilePage())
    

    var body: some View {
        TabView(selection: self.router.tabBinding) {
            
            TabPage(tab: .home) {
                feedPage
            }
            
            TabPage(tab: .profile) {
                profilePage
            }
        }
    }
}

struct LazyView<Content: View>: View {
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}

#Preview {
    VBTabView()
}
