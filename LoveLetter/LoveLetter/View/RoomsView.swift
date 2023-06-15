import SwiftUI

struct RoomsView: View {
    @State var roomID: String = ""
    @State var goWaiting = false
    @StateObject var RoomModel: RoomViewModel = RoomViewModel()
    @StateObject var AccountModel = AccountViewModel()
    var body: some View {
        VStack{
            Text("Enter your friends room ID: ")
            TextField("room ID", text: $roomID)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
            Button("GO!"){
                goWaiting = true
            }
            .ButtonStyle()
            
        }
        .navigate(to: WatingView(roomID: $roomID), when: $goWaiting)
        
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsView()
    }
}
