//
//  SalonListView.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 29.11.2024.
//

import SwiftUI

struct MyModel : Identifiable {
 var id: Int
  var bgImage : String
    var salonTitle : String
    var rating : Double
    var isFavorite : Int
    var profileImg : String?
    var adress : String
    var distance : String
}

struct SalonListView: View {
    @Binding var isLoggedIn: Bool
    @State private var state = "Bekleniyor"
    @State var mymodel: [MyModel] = []
    @State private var selectedModel: MyModel? = nil
    @State private var navigateToProfile: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(mymodel) { model in
                        NavigationLink(destination: DetailView(model: model)) {
                            VStack(alignment: .leading, spacing: 8) {
                                AsyncImage(url: URL(string: model.bgImage)) { phase in
                                    switch phase {
                                    case .empty:
                                        Color(.purple)
                                            .frame(width: 350, height: 150)
                                            .cornerRadius(15)
                                            .overlay(Text("Yükleniyor...").foregroundColor(.white))
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 350, height: 150)
                                            .cornerRadius(15)
                                            .clipped()
                                    case .failure:
                                        Color.red
                                            .frame(width: 350, height: 150)
                                            .cornerRadius(15)
                                            .overlay(Text("Error").foregroundColor(.white))
                                    }
                                }
                                Text(model.salonTitle)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                Ratings(rating: model.rating)
                                    .frame(alignment: .leading)
                                    .foregroundColor(.black)
                                Button {
                                    toggleFavorite(id: model.id)
                                } label: {
                                    Text("Add to Favorites")
                                        .frame(alignment: .leading)
                                    Image(systemName: (model.isFavorite != 0) ?
                                          "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                        .frame(alignment: .leading)
                                        .foregroundColor((model.isFavorite != 0) ? .red : .red)
                                        .frame(alignment: .leading)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .onAppear(perform: FindClosestSalons)
            .navigationTitle("BiCoiffeur")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        navigateToProfile = true
                    }) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                }
            }
            .background(
                NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
                    EmptyView()
                }
            )
        }
    }
    
    func toggleFavorite(id: Int) {
        // Favori işlemleri
    }
    
    func FindClosestSalons() {
        let request = FindClosestSalonsRequest()
        request.SearchValue = ""
        
        AuthenticationManager.instance.FindClosestSalons(parameters: request, success: { response in
            
            response?.list?.forEach{ a in
                mymodel.append(MyModel(id:a.Id!, bgImage: a.BackgroundImageUrl ?? "", salonTitle: a.Title!, rating: a.Rating!, isFavorite: a.IsFavorite, profileImg: a.ProfileImageUrl ?? "", adress: a.Address ?? "", distance: a.DistanceStr ?? ""))
            }
            
            
        }) {
            error in
            print(error)
        }
    }
}








