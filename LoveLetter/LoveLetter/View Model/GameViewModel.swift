import Foundation
import FirebaseFirestoreSwift
import Firebase

class GameViewModel: ObservableObject {
    @Published var game: Game = Game()
    @Published var playerIndex: Int = 0
    @Published var playerKey: String = ""
    @Published var selectedCardIndex = 0
    @Published var myTurn = false
    @Published var isWin = false
    @Published var opponentKey: String = ""
    var gameListener: ListenerRegistration?
    
    deinit {
        stopObservingGame()
    }
    
    let db = Firestore.firestore()
    
    func watchGame(ID: String, accID: String){
        guard ID == "" else {
            self.game.id = ID
            let docRef = Firestore.firestore().collection("games").document(self.game.id!)
            docRef.getDocument(as: Game.self) { result in
                switch result {
                case .success(let game):
                    self.game = game
                    self.playerIndex = game.players[accID]!.index
                    self.playerKey = self.getCurrentPlayerKey()
                    self.opponentKey = self.getOpponentKey()
                    self.checkOver()
                    self.observeGame()
                case .failure(let error):
                    print(error.localizedDescription)
                    print("In watch game")
                }
              }
            return
        }
    }
    
    func initGame(players: [String], ID: String){
        print(players)
        self.game.id = ID
        for (index, id) in players.enumerated() {
            game.players[id] = Player(index: index, cards: [], isProtected: false, isOut: false)
            var card = game.deck.popLast()!
            game.players[id]?.cards.append(card)
            card = game.deck.popLast()!
            game.players[id]?.cards.append(card)
            print(game.deck)
        }
        updateGame()
    }
    
    func checkOver(){
        if(game.deck.isEmpty){
            gameOver()
        }
    }
    
    func gameOver(){
        game.isOver = true
        var opponentScore = 0, myScore = 0
        for key in Array(game.players.keys){
            if key == playerKey{
                myScore += (game.players[key]?.cards.reduce(0, +))!
            }else{
                opponentScore += (game.players[key]?.cards.reduce(0, +))!
            }
        }
        print("This is myScore: \(myScore)")
        if myScore > opponentScore{
            isWin = true
        }
    }
    
    func getCurrentPlayerKey() -> String {
        for key in Array(game.players.keys){
            if game.players[key]?.index == playerIndex{
                return key
            }
        }
        return ""
    }
    
    func getOpponentKey() -> String {
        for key in Array(game.players.keys){
            if game.players[key]?.index != playerIndex{
                return key
            }
        }
        return ""
    }
    
    func playCard(){
        
        game.lastCard = (game.players[playerKey]?.cards[selectedCardIndex])!
        
        let card = game.deck.popLast()!
        game.players[playerKey]?.cards[selectedCardIndex] = card
        
        game.nextPlayerIndex = (game.nextPlayerIndex+1)%(game.players.count)
        checkOver()
        updateGame()
    }
    
    func updateGame() {
        if let id = game.id {
            let docRef = db.collection("games").document(id)
            do {
              try docRef.setData(from: game)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func observeGame() {
        let gameRef = Firestore.firestore().collection("games").document(game.id!)
        gameListener = gameRef.addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot = snapshot, snapshot.exists else {
                // Room document doesn't exist or there was an error
                print("game error")
                self?.stopObservingGame()
                return
            }

            do {
                self?.game = try snapshot.data(as: Game.self)
                print("update complete")
            } catch {
            }
        }
    }
    
    func stopObservingGame() {
        //print("reset room observer")
        gameListener?.remove()
        gameListener = nil
    }
    
    
}
