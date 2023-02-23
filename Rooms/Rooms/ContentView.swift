//
//  ContentView.swift
//  Rooms
//
//  Created by henry on 2023/2/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = RoomStore(rooms: testData)
    
    var body: some View {
        NavigationView {
            // 列表
            List{
                Section{
                    Button (action: addRoom){
                        Text("Add Room")
                    }
                }
                Section{
                    ForEach(store.rooms){ room in
                        RoomCell(room: room)
                    }
                    .onDelete(perform: deleteRoom(at:))
                    .onMove(perform: move(from:to:))
                }
            }
            .navigationBarTitle("Rooms")
            .navigationBarItems(trailing: EditButton())
            .listStyle(.grouped)
            
        }
    }
    
    func addRoom(){
        store.rooms.append(Room(name: "Hall 2", capacity: 200))
    }
    
    func deleteRoom(at offset:IndexSet){
        store.rooms.remove(atOffsets: offset)
    }
    
    func move(from source:IndexSet, to destination:Int){
        store.rooms.move(fromOffsets: source, toOffset: destination)
        
    }
    
}

struct RoomCell: View {
    var room:Room
    var body: some View {
        NavigationLink(destination: RoomDetail(room: room)) {
            HStack {
                Image(room.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(5)
                VStack(alignment: .leading){
                    Text(room.name)
                    Text("\(room.capacity) people")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView(store: RoomStore(rooms: testData))
            ContentView(store: RoomStore(rooms: testData)).environment(\.sizeCategory, .extraExtraLarge)
            ContentView(store: RoomStore(rooms: testData)).environment(\.colorScheme, .dark)
            ContentView(store: RoomStore(rooms: testData))
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.locale, Locale(identifier: "ar"))
        }
    }
}
#endif
