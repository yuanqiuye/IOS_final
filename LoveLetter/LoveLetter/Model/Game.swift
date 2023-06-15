import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Player: Codable, Hashable {
    var index: Int = 0
    var cards: [Int] = []
    var isProtected: Bool = false
    var isOut: Bool = false
}

struct Game: Codable {
    @DocumentID var id: String?
    var players: [String: Player] = [:]
    var deck: [Int] = [1,1,1,1,2,2,2,3,3,3,4,4,5,5,6,6,7,8].shuffled()
    var lastCard: Int = 10
    var nextPlayerIndex: Int = 0
    var isOver: Bool = false
}

extension Binding where Value == Player? {
    func toNonOptional() -> Binding<Player> {
        return Binding<Player>(
            get: {
                return self.wrappedValue ?? Player()
            },
            set: {
                self.wrappedValue = $0
            }
        )
    }
}

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}

struct ButtonLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding(10)
            .foregroundColor(.white)
            .background(.black)
            .clipShape(Capsule())
    }
}

extension View {
    func ButtonStyle() -> some View {
        self.modifier(ButtonLabel())
    }
}
