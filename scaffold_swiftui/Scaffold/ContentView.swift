//
//  ContentView.swift
//  Scaffold
//
//  Created by ihenry on 2024/5/6.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @Environment(Router.self) private var router

    var body: some View {
        VBTabView()
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
