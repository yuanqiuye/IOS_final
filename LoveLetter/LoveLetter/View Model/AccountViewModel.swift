import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class AccountViewModel: ObservableObject{
    @Published var user: User = User()
    @Published var isLogged: Bool = false
    
    init(){
        checkIsLogged()
    }
    
    func checkIsLogged() {
        if let user = Auth.auth().currentUser {
            self.user.id = user.uid
            self.user.email = user.email ?? ""
            self.user.name = user.displayName ?? ""
            self.isLogged = true
        } else {
            self.isLogged = false
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            guard let user = result?.user,
                error == nil else {
                let _ = print(error!.localizedDescription)
                return
            }
            self.setUserInfo()
            self.user.id = user.uid
        }
        self.isLogged = true
    }
    
    func setUserInfo(){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.user.name
        changeRequest?.commitChanges(completion: { error in
           guard error == nil else {
               return
           }
        })
    }
    
    func login() {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            guard let user = result?.user,
                error == nil else {
                return
            }
            self.isLogged = true
            self.user.id = user.uid
            self.user.name = user.displayName ?? ""
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.isLogged = false
        } catch {
            
        }
    }
    
}
