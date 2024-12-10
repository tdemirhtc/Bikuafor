//
//  LoginView.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 29.11.2024.
//

import SwiftUI
struct LoginView: View {
    //@AppStorage("isLoggedIn") var isLoggedIn: Bool = false
   // @State private var isLoggedIn: Bool = false
    @Binding var isLoggedIn: Bool
   // @State private var loginResponse: LoginResponse?
    @State private var state: String = "Henüz giriş yapılmadı"
    @State private var navigateToSalonList: Bool = false
    var body: some View {
        NavigationView{
        VStack(spacing: 20) {
            Text("Giriş Yap")
                .font(.largeTitle)
                .padding()
            
            Button("Login") {
                login()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Text(state)
                .foregroundColor(.red)
                .padding()
            NavigationLink(
                destination: SalonListView(isLoggedIn: $isLoggedIn), isActive: $navigateToSalonList) {
            EmptyView() }
                         
        }
        .navigationTitle("Login")
    }
      
    }
    func login() {
        let request = LoginRequest()
        request.Username = "haticetasdemir@gmail.com"
        request.Password = "112233"
        
        AuthenticationManager.instance.login(parameters: request, success: { response in
            if let token = response?.LoginToken  {
              DispatchQueue.main.async{
                  //  isLoggedIn = true 
                    state = "Giriş başarılı: Hoş geldiniz, \(response?.Name ?? "Kullanıcı") \(response?.Surname ?? "")."
                  //save işlemi
                  StaticVariables.loginToken = (response?.LoginToken)!
                   UserDefaultManager.setValue(key: "LoginToken", value: response?.LoginToken)
                  if let userId = response?.Id{
                      print("Kullanıcı ID'si: \(userId)")
                      UserDefaultManager.setValue(key: "userId", value: response?.Id)
                     
                  }
                 navigateToSalonList = true
        }
            }
            else {
               DispatchQueue.main.async {
                    state = "Giriş başarısız: Kullanıcı bilgileri doğrulanamadı."
               }
            }
        }) { error in
            print(error)
        }
        
    }
}
   
    

