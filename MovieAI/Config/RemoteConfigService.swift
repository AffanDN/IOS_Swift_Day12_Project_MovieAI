//
//  RemoteConfigService.swift
//  MovieAI
//
//  Created by Macbook Pro on 02/05/24.
//

import Foundation
import Firebase

class RemoteConfigService: RemoteConfigurable {
    static let shared = RemoteConfigService()
    
    // Pertama, kita butuh satu variable untuk mengatur berapa interval fetch data ke Firebase RemoteConfig dari local code kita
    private var remoteConfig = RemoteConfig.remoteConfig()
    
    private init() {
        configure()
    }
    
    func configure() {
        #if DEBUG
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0  //Waktu untuk Development
        #else
        settings.minimumFetchInterval = 86400 // Waktu untuk production
        #endif
        
        remoteConfig.configSettings = settings
    }
    
    // Fetch and Activate configuration, simpan hasilnya sebagai status
    func fetchConfig<T>(forKey key: ConfigKeys) async throws -> T where T : Decodable {
        let status = try await remoteConfig.fetchAndActivate()
        switch status {
        case .successFetchedFromRemote:
            print("Configuration Fetched from remote and activated")
        case .successUsingPreFetchedData:
            print("Pre-fteched data available and activated")
        case .error:
            print("An error occured while fetching remote config")
        @unknown default:
            print("An Unknown status was returned")
        }
        
        // Pastikan bahwa nilai dari config value yang kita set di firebase remote config berupa String
        let stringValue = remoteConfig.configValue(forKey: key.rawValue).stringValue ?? ""
        print("Fetched value for \(key.rawValue): \(stringValue)")
        
        if T.self == String.self, let stringValue = stringValue as? T {
            return stringValue
        }
        
        // Jika ternyata di decode, generic T itu bukan sebuah string, kita guard agar tidak crash
        guard let data = stringValue.data(using: .utf8)
        else {
            throw ErrorConfiguration.failedToConvertData(key: key.rawValue)
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw ErrorConfiguration.failedToDecodeData(key: key.rawValue, underlyingError: error)
        }
    }
}

enum ErrorConfiguration: Error, LocalizedError {
    case failedToDecodeData(key: String, underlyingError: Error)
    case failedToConvertData(key: String)
    
    var errorDescription: String? {
        switch self {
        case .failedToDecodeData(let key, let underlyingError):
            return "Failed to Decode Configuration for key: \(key). Error: \(underlyingError.localizedDescription)"
        case .failedToConvertData(key: let key):
            return "Failed to Convert configuration for key: \(key) to data"
        }
    }
}

protocol RemoteConfigurable {
    func fetchConfig<T: Decodable>(forKey key: ConfigKeys) async throws -> T
}

enum ConfigKeys: String {
    case apiKey = "API_KEY"
    
}
