//
//  NavStack.swift
//  VisionTwitch
//
//  Created by Adam Gastineau on 2/18/24.
//

import SwiftUI

struct NavStack<Content: View>: View {
    @Environment(Router.self) private var router

    let tab: Tab

    let content: () -> Content

    var body: some View {
        NavigationStack(path: self.router.pathBinding(for: self.tab)) {
            self.content()
        }
    }
}

struct PreviewNavStack<Content: View>: View {
    @State var router = Router()

    let content: () -> Content

    var body: some View {
        NavStack(tab: .home) {
            self.content()
        }
        .environment(self.router)
    }
}
