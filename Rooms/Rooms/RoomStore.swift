//
//  RoomStore.swift
//  Rooms
//
//  Created by henry on 2023/2/23.
//

import Foundation

class RoomStore : ObservableObject{
    @Published var rooms:[Room]
    init(rooms: [Room]) {
        self.rooms = rooms
    }
}
