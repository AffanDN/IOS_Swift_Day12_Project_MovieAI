//
//  ContentView.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movieData = MovieAIViewModel()
    @State private var selectedGenre: Genre = .action
    @State private var selectedYear: YearMovie = .y2000
    var body: some View {
        NavigationStack {
            Form {
                
                // MARK: - PICKER GENRE & YEAR
                Section {
                    // PICKER YEAR
                    Picker(selection: $selectedGenre) {
                        ForEach(Genre.allCases) {
                            genre in
                            Text(genre.rawValue)
                                .font(.subheadline)
                               
                            // untuk memilih yang sudah ditag / dipilih
                                .tag(genre)
                        }
                    } label: {
                        Text("Choose Genre")
                    }
                    .pickerStyle(.navigationLink)
                    
                    // PICKER YEAR
                    Picker(selection: $selectedYear) {
                        ForEach(YearMovie.allCases) {
                            year in
                            Text(year.rawValue)
                                .font(.subheadline)
                               
                            // untuk memilih yang sudah ditag / dipilih
                                .tag(year)
                        }
                    } label: {
                        Text("Choose Year")
                    }
                    .pickerStyle(.navigationLink)
                }
                // MARK: - GENERATE STORY

                Button {
                    generateMovie()
                } label: {
                    Text("Generate Movie")
                }
                .buttonStyle(PlainButtonStyle())
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)

                
                // MARK: - LIST ROW
                List {
                    ForEach(movieData.movie, id: \.self) {
                        item in VStack {
                            MovieRow(movieai: item)
                        }
                    }
                }
            }
            .navigationTitle("Movie AI")
//            .overlay{
//                movieData.movie.isEmpty ? ProgressView() : nil
//            }
//            .onChange(of: movieData.isReady, { oldValue, newValue in
//                if newValue {
//                    Task {
//                        await movieData.generateMovie(genre:year:)
//                    }
//                }
//        })
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    func generateMovie() {
        Task{
          await movieData.generateMovie(genre:selectedGenre,year:selectedYear)
        }
    }
}
