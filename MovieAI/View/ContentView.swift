//
//  ContentView.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movieDataVM = MovieAIViewModel()
    @State private var selectedGenre: Genre = .action
    @State private var selectedYear: YearMovie = .y2000
    @State private var isShowing: Bool = false
    
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
                
                // MARK: - LIST ROW
                List {
                    ForEach(movieDataVM.movie, id: \.self) {
                        item in
                        VStack {
                            MovieRow(movieai: item)
                        }
                    }
                }
                
//                if !isShowing {
//                    Image(systemName: "list.and.film")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .foregroundStyle(.gray)
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
//                        .opacity(!isShowing ? 1 : 0)
//                } else {
//                    List {
//                        ForEach(movieDataVM.movie, id: \.self) {
//                            item in
//                            VStack {
//                                MovieRow(movieai: item)
//                            }
//                        }
//                    }
//                }
                
            }
            .navigationTitle("Movie AI")
            .padding(.bottom)
            // MARK: - GENERATE STORY
            
            Button {
                generateMovie()
//                    isShowing.toggle()
            } label: {
                Text("✨ Generate Movie")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color.indigo)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
            Text("Copyright ©️ 2024 Movie AI")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.vertical, 8)
        }
        .overlay(movieDataVM.isLoading ? ProgressView() : nil)

        //            .overlay{
        //                if movieDataVM.isLoading {
        //                    ProgressView()
        //                } else {
        //                    Image(systemName: "list.and.film")
        //                        .resizable()
        //                        .frame(width: 100, height: 100)
        //                        .foregroundStyle(.gray)
        //                        .opacity(movieDataVM.isLoading ? 0 : 1)
        //
        //                }
        //            }
    }
}


#Preview {
    ContentView()
}

extension ContentView {
    func generateMovie() {
        Task{
            await movieDataVM.generateMovie(genre:selectedGenre,year:selectedYear)
        }
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { scene in
                scene as? UIWindowScene
            }
            .filter { filter in
                filter.activationState ==
                    .foregroundActive
            }
            .first?.keyWindow
    }
}
