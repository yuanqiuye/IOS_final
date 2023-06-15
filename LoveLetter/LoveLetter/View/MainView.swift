import SwiftUI

struct MainView: View {
    @StateObject var AccountModel = AccountViewModel()
    @StateObject var RoomModel: RoomViewModel = RoomViewModel()
    @State var goSetting = false
    @State var goRoom = false
    @State var goWating = false
    @State var roomID: String = ""
    var body: some View {
        VStack{
            HStack(spacing: 230){
                Image(systemName: "flag.2.crossed.fill")
                    .font(.title)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(.white)
                    .clipShape(Capsule())
                    
                Image(systemName:"gearshape.fill")
                    .font(.title)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(.black)
                    .clipShape(Capsule())
                    .onTapGesture {
                        goSetting = true
                    }
            }
            Spacer()
                .frame(height: 20)
            Text("情書")
                .font(.title)
            Spacer()
                .frame(height: 70)
            Button("創建房間"){
                if AccountModel.isLogged == false {
                    goSetting = true
                    return
                }
                roomID = String(Int.random(in: 1000...9999))
                goWating = true
            }
            .ButtonStyle()
            Spacer()
                .frame(height: 20)
            Button("加入房間"){
                print(AccountModel.isLogged)
                if AccountModel.isLogged == false {
                    goSetting = true
                    return
                }
                goRoom = true
            }
            .ButtonStyle()
            Spacer()
        }
        .navigate(to: SettingView(goMain: $goSetting), when: $goSetting)
        .navigate(to: RoomsView(), when: $goRoom)
        .navigate(to: WatingView(roomID: $roomID), when: $goWating)
    }
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
