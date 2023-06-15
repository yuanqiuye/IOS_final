import Foundation
import FirebaseFirestoreSwift



struct Room: Codable, Hashable{
    @DocumentID var id: String? = ""
    var players: [String: String] = [:]
    var status: Int = 0
}
