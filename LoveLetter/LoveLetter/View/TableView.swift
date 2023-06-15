import SwiftUI

struct TableView: View {
    @EnvironmentObject var GameModel: GameViewModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
                .opacity(0.7)
                .frame(width: 350, height: 150)
            
            HStack{
                VStack{
                    Text("上一張牌")
                        .font(.headline)
                        .offset(y:45)
                    CardView(cardID: $GameModel.game.lastCard)
                }
                VStack{
                    Text("牌組 (\(GameModel.game.deck.count))")
                        .font(.headline)
                        .offset(y:45)
                    if GameModel.game.deck.isEmpty{
                        CardView(cardID: Binding.constant(10))
                    }else{
                        CardView(cardID: Binding.constant(9))
                    }
                }
            }
        }
        
    }
}

