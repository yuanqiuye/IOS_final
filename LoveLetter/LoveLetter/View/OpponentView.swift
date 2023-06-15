import SwiftUI

struct OpponentView: View {
    @EnvironmentObject var GameModel: GameViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .opacity(0.7)
                .frame(width: 350, height: 150)
            VStack(spacing: 10){
                Text("對手的手牌")
                    .font(.headline)
                    .offset(y:40)
                HStack{
                    if GameModel.game.players[GameModel.opponentKey] != nil {
                        if GameModel.game.isOver {
                            CardView(cardID: ($GameModel.game.players[GameModel.opponentKey].toNonOptional().cards[0]) )
                            CardView(cardID: ($GameModel.game.players[GameModel.opponentKey].toNonOptional().cards[1]) )
                        }else{
                            CardView(cardID: Binding.constant(9))
                            CardView(cardID: Binding.constant(9))
                        }
                    }
                }
            }
            
        }
    }
}


