import SwiftUI

struct CardView: View {
    @Binding var cardID: Int
    var body: some View {
        Image("cards")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .offset(x:CGFloat(-(cardID-1)*127), y:0)
            .frame(width: 127, height: 175, alignment: .topLeading)
            .clipped()
            .scaleEffect(0.5)
            .contentShape(Rectangle())
            
            
            
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            CardView(cardID: Binding.constant(9))
                
            CardView(cardID: Binding.constant(8))
                
        }
        
    }
}
