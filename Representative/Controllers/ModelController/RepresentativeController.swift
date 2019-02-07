//
//  RepresentativeController.swift
//  Representative
//
//  Created by Chris Grayston on 2/7/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseURL = URL(string: "http://whoismyrepresentative.com/getall_reps_bystate.php")
    
    static func searchRepresentatives(forState state: String, completion: @escaping ([Representative]) -> Void) {
        
        guard let baseURL = baseURL else { completion([]); return }
        
        
        let stateQuery = URLQueryItem(name: "state", value: state.lowercased())
        let jsonQuery = URLQueryItem(name: "output", value: "json")
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [stateQuery, jsonQuery]
        guard let urlRequest = components?.url else { completion([]); return}
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("Error creating dataTask: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data,
            let fixedData = String(data: data, encoding: .ascii)?.data(using: .utf8) else {
                print("Error unwrapping data in searchRepresentatives function")
                completion([])
                return
            }
            
            let decode = JSONDecoder()

            do {
                let resultsDictionary = try decode.decode([String:[Representative]].self, from: fixedData)
                let representativeArray = resultsDictionary["results"]
                completion(representativeArray ?? [])
            } catch {
                print("Error decoding json: \(error.localizedDescription)")
                completion([])
                return
            }
        }
        dataTask.resume()
    }
    
}
