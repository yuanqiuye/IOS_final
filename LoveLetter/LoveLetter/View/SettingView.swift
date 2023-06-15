import SwiftUI

struct SettingView: View {
    @StateObject var AccountModel = AccountViewModel()
    @Binding var goMain: Bool
    var body: some View {
        VStack{
            if AccountModel.isLogged {
                Text("Name: \(AccountModel.user.name)")
                Button("Logout"){
                    goMain = false
                    AccountModel.logOut()
                }
                .ButtonStyle()
                Button("Back"){
                    goMain = false
                }
                .ButtonStyle()
            } else {
                TextField("Account", text: $AccountModel.user.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                TextField("Password", text: $AccountModel.user.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                TextField("Name", text: $AccountModel.user.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                Button("Register"){
                    AccountModel.register()
                    goMain = false
                }
                .ButtonStyle()
                Button("Login"){
                    AccountModel.login()
                    goMain = false
                }
                .ButtonStyle()
                Button("Back"){
                    goMain = false
                }
                .ButtonStyle()
            }
            
        }
    }
}
