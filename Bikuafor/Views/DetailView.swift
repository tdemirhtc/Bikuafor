//
//  DetailView.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 29.11.2024.
//

import SwiftUI

struct DetailView: View {
    var model: MyModel
   // @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            if let profileImageUrl = model.profileImg {
                AsyncImage(url: URL(string: profileImageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                        .overlay(Text("Yükleniyor...").foregroundColor(.white))
                }
            }
            Text(model.salonTitle)
                .font(.title)
            Text("Adress: \(model.adress)")
                .font(.subheadline)
            Text("Meafe: \(model.distance)")
                .font(.subheadline)
            Ratings(rating: model.rating)
            
        }
        .padding()
        .navigationTitle("Salon Detayları")
        /*.toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
              Button(action: {
                    dismiss()
                }) {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Geri")
                    }
                }
                
            }
        }*/
    }
}
