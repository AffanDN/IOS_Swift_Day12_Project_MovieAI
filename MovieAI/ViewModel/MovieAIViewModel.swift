//
//  MovieAIViewModel.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import Foundation
import GoogleGenerativeAI

@MainActor
class MovieAIViewModel: ObservableObject {
    private var geminiModel: GenerativeModel?
    @Published var movie: [MovieAIModel] = []
    @Published var isReady = false
    
    init() {
        configureGenerativeModel()
    }
    
    func generateMovie(genre: Genre, year: YearMovie) async {
        let genreString = genre.rawValue
        let yearString = year.rawValue
        
        let prompt = """
        give me recommendations for films with the \(genreString) genre in \(yearString). Please provide the output in JSON String format as
            [
              {
                "title": "",
                "genre": "",
                "image": "",
               "rating_imdb": "",
               "synopsis": "",
               "trailer": ""
              }
            ]
        only. Remove any bacticks
        """
        
        guard let geminiModel = self.geminiModel else {
            print("Generative Model is not Configured")
            return
        }
        do {
            let response = try await geminiModel.generateContent(prompt)
            // Proses Encoding
            guard let text = response.text, let data = text.data(using: .utf8)
            else {
                print("🤪 Unable to Extract Text or Convert to Data")
                return
            }
            // Proses Decoding
            movie = try JSONDecoder().decode([MovieAIModel].self, from: data)
        } catch {
            print("🤬 ERROR: Fetching places: \(error.localizedDescription)")
        }
    }
    
    func configureGenerativeModel() {
        Task {
            do {
                let apiKey: String = try await RemoteConfigService.shared.fetchConfig(forKey: .apiKey)
                self.geminiModel = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
                self.isReady = true
            } catch {
                print("Error Configuring GenerativeModel: \(error)")
            }
        }
    }
}
