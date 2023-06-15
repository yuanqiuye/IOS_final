import Foundation

class User: ObservableObject{
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}
