import SwiftUI

struct GameView: View {
    @State var gameID: String
    @StateObject var GameModel = GameViewModel()
    @StateObject var AccountModel = AccountViewModel()
    @State var goMain = false
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                if $GameModel.game.nextPlayerIndex.wrappedValue == $GameModel.playerIndex.wrappedValue {
                    Text("Your Turn")
                        .font(.title)
                        .padding(10)
                        .background(.white)
                        .clipShape(Capsule())
                }else{
                    Text("Waiting...")
                        .font(.title)
                        .padding(10)
                        .background(.white)
                        .clipShape(Capsule())
                }
                
                OpponentView()
                
                if $GameModel.game.isOver.wrappedValue {
                    GameOverView(control: $goMain)
                }else{
                    TableView()
                }
                
                PlayerView()
            }
            .environmentObject(GameModel)
            .onAppear{
                GameModel.watchGame(ID: gameID, accID: AccountModel.user.id)
            }
        }
        .navigate(to: MainView(), when: $goMain)
    }
}

/**
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
 **/
