import SwiftUI

struct WatingView: View {
    @State var roomID: String
    @StateObject var RoomModel: RoomViewModel = RoomViewModel()
    @StateObject var AccountModel = AccountViewModel()
    var GameModel: GameViewModel = GameViewModel()
    init(roomID: Binding<String>) {
        self.roomID = roomID.wrappedValue
    }
    var body: some View {
        VStack{
            Text("Room ID: \(roomID)\n")
            Text("Players: ")
            ForEach(Array(RoomModel.room.players.keys), id: \.self) {key in
                Text(RoomModel.room.players[key] ?? "" )
            }
            Button("Start!"){
                GameModel.initGame(players: Array(RoomModel.room.players.keys), ID: roomID)
                RoomModel.startRoom()
            }
            .ButtonStyle()
        }
        .onAppear{
            RoomModel.watchRoom(ID: self.roomID, accID: AccountModel.user.id, name: AccountModel.user.name)
        }
        .navigate(to: GameView(gameID: roomID), when: Binding.constant($RoomModel.room.status.wrappedValue == 1))
        
    }
        
}
