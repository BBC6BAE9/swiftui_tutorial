//
//  RoomsApp.swift
//  Rooms
//
//  Created by henry on 2023/2/23.
//

import SwiftUI

@main
struct RoomsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: RoomStore(rooms: testData))
        }
    }
}
