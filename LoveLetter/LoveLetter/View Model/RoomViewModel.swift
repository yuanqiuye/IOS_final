import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class RoomViewModel: ObservableObject {
    @Published var room: Room = Room()
    var roomListener: ListenerRegistration?
    
    deinit {
        stopObservingRoom()
    }
    
    func watchRoom(ID: String, accID: String, name: String){
        guard ID == "" else {
            self.room.id = ID
            let docRef = Firestore.firestore().collection("rooms").document(self.room.id!)
            docRef.getDocument(as: Room.self) { result in
                switch result {
                case .success(let room):
                    self.room = room
                    self.joinRoom(ID: accID, name: name)
                case .failure(let error):
                    print("Create Room")
                    self.joinRoom(ID: accID, name: name)
                }
              }
            return
        }
    }
    
    func joinRoom(ID: String, name: String){
        if room.id == "" {
            print("join room get blank id!")
        }
        self.room.players[ID] = name
        print(self.room.players.count)
        updateRoom()
    }
    
    func startRoom(){
        room.status = 1
        updateRoom()
    }
    
    func updateRoom() {
        if let id = room.id {
            let docRef = Firestore.firestore().collection("rooms").document(id)
            do {
              try docRef.setData(from: room)
              observeRoom()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func observeRoom() {
        let roomRef = Firestore.firestore().collection("rooms").document(room.id!)
        roomListener = roomRef.addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot = snapshot, snapshot.exists else {
                // Room document doesn't exist or there was an error
                print("room error")
                self?.stopObservingRoom()
                return
            }

            do {
                self?.room = try snapshot.data(as: Room.self)
            } catch {
            }
        }
    }
    
    func stopObservingRoom() {
        //print("reset room observer")
        roomListener?.remove()
        roomListener = nil
    }
}
