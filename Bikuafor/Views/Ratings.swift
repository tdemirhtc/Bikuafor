//
//  Ratings.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 2.12.2024.
//

import SwiftUI

struct Ratings: View {
    var  rating: Double
   var maxStars: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxStars, id: \.self) { index in
                if Double(index) < rating {
                    if Double(index + 1) <= rating {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    } else {
                        Image(systemName: "star.leadinghalf.filled") 
                            .foregroundColor(.yellow)
                    }
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}


