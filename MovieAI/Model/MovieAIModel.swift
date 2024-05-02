//
//  MovieAIModel.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import Foundation

struct MovieAIModel: Codable, Hashable {
    var title: String
    var genre: Genre
    var image: String
    var rating_imdb: String
    var trailer: String
    var synopsis: String
}

enum Genre: String, CaseIterable, Identifiable, Codable {
    case action = "Action"
    case adventure = "Adventure"
    case animation = "Animation"
    case biography = "Biography" // Biografi
    case comedy = "Comedy" // Komedi
    case crime = "Crime" // Kriminal
    case documentary = "Documentary" // Dokumenter
    case drama = "Drama"
    case family = "Family" // Keluarga
    case fantasy = "Fantasy" // Fantasi
    case history = "History" // Sejarah
    case horror = "Horror" // Horor
    case music = "Music" // Musik
    case musical = "Musical" // Musikal
    case mystery = "Mystery" // Misteri
    case romance = "Romance" // Romantis
    case sciFi = "Sci-Fi" // Fiksi Ilmiah
    case short = "Short" // Pendek
    case sport = "Sport" // Olahraga
    case thriller = "Thriller" // Thriller
    case war = "War" // Perang
    case western = "Western" // Barat
    var id: String {self.rawValue}
}

enum YearMovie: String, CaseIterable, Identifiable, Codable {
    case y2000 = "2000"
    case y2001 = "2001"
    case y2002 = "2002"
    case y2003 = "2003"
    case y2004 = "2004"
    case y2005 = "2005"
    case y2006 = "2006"
    case y2007 = "2007"
    case y2008 = "2008"
    case y2009 = "2009"
    case y2010 = "2010"
    case y2011 = "2011"
    case y2012 = "2012"
    case y2013 = "2013"
    case y2014 = "2014"
    case y2015 = "2015"
    case y2016 = "2016"
    case y2017 = "2017"
    case y2018 = "2018"
    case y2019 = "2019"
    case y2020 = "2020"
    case y2021 = "2021"
    case y2022 = "2022"
    case y2023 = "2023"
    case y2024 = "2024"
    var id: YearMovie {self}
}

extension MovieAIModel {
    static let dummyData: [MovieAIModel] = [
        MovieAIModel(
            title: "Ice Age: The Meltdown",
            genre: Genre(rawValue: "Action")!,
            image: "https://www.imdb.com/title/tt0438097/",
            rating_imdb: "8.5",
            trailer: "https://www.youtube.com/watch?v=s4PWGVtIZWA",
            synopsis: "Manny si mamut, Sid si sloth, dan Diego si harimau harimau harus bekerja sama untuk menemukan cara bertahan hidup saat Zaman Es mulai mencair dan air laut naik."
        )
    ]
}
