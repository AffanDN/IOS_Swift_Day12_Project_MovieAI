//
//  MovieRow.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import SwiftUI
import SafariServices

struct MovieRow: View {
    var movieai: MovieAIModel
    var body: some View {
        HStack (spacing: 16) {
            AsyncImage(url: URL(string: movieai.image)) { image in
                image.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 120, height: 180)
                    .scaledToFit()
            } placeholder: {
                ZStack {
                    Color.gray
                    WaitingView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 120, height: 180)
            }
            
            VStack (alignment: .leading, spacing: 8) {
                Text(movieai.title)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(movieai.genre.rawValue)
                    .font(.subheadline)
                Text("⭐️ \(movieai.rating_imdb)")
                Text(movieai.synopsis)
                    .font(.caption)
                    .lineLimit(3)
                Button {
                    let linkTrailer = SFSafariViewController(url: URL(string: movieai.trailer)!)
                    UIApplication.shared.firstKeyWindow?.rootViewController?.present(linkTrailer, animated: true)
                } label: {
                    Text("▶️ Trailer")
                        .font(.caption)
                }
            }

        }
    }
}

#Preview {
    MovieRow(movieai: MovieAIModel.dummyData[0])
        .padding()
}

@ViewBuilder
func WaitingView() -> some View {
    VStack(spacing: 20) {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.mint)
    }
}
