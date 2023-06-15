import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var GameModel: GameViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .opacity(0.7)
                .frame(width: 350, height: 150)
            VStack(spacing: 10){
                Text("你的手牌")
                    .font(.headline)
                    .offset(y:40)
                HStack{
                    if GameModel.game.players[GameModel.playerKey] != nil{
                        CardView(cardID: ($GameModel.game.players[GameModel.playerKey].toNonOptional().cards[0]) )
                            .allowsHitTesting($GameModel.game.nextPlayerIndex.wrappedValue == $GameModel.playerIndex.wrappedValue && $GameModel.game.isOver.wrappedValue == false)
                            .onTapGesture{
                                GameModel.selectedCardIndex = 0
                                GameModel.playCard()
                                
                            }
                        CardView(cardID: ($GameModel.game.players[GameModel.playerKey].toNonOptional().cards[1]) )
                            .allowsHitTesting($GameModel.game.nextPlayerIndex.wrappedValue == $GameModel.playerIndex.wrappedValue && $GameModel.game.isOver.wrappedValue == false)
                            .onTapGesture{
                                GameModel.selectedCardIndex = 1
                                GameModel.playCard()
                                
                            }
                    }
                    
                }
            }
        }
        
    }
}


