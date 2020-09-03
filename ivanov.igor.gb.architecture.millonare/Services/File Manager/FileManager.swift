//
//  FileManager.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import Foundation

class FilesManager {
    
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    
    var fileManager: FileManager!
    
    private init(){
        fileManager = FileManager()
        fileManager = .default
    }
    
    static let shared: FilesManager = FilesManager()
    
    func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        do {
            print(url)
            try data.write(to: url)
        } catch {
            debugPrint(error)
            throw Error.writtingFailed
        }
    }
    
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
    
    
    func read(fileNamed: String) throws -> Data {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        //  guard fileManager.fileExists(atPath: url.absoluteString) else {
        //     throw Error.fileNotExists
        //  }
        print(url)
        
        do {
            return try Data(contentsOf: url)
        } catch {
            debugPrint(error)
            throw Error.readingFailed
        }
    }
}


//MARK:- Profile
extension FilesManager {
    
    func saveGameResult(results: [GameResult]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(results)
            try save(fileNamed: "results", data: data)
        } catch let err {
            print(err)
        }
    }
    
    
    func loadGameResult() -> [GameResult]? {
        do {
            let data = try read(fileNamed: "results")
            let decoder = JSONDecoder()
            let results = try decoder.decode([GameResult].self, from: data)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
