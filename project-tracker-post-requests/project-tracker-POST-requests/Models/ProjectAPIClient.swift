//
//  ProjectAPIClient.swift
//  project-tracker-POST-requests
//
//  Created by Sunni Tang on 9/12/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct ProjectAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = ProjectAPIClient()
    
    // MARK: - Internal Methods
    
    func getProjects(completionHandler: @escaping (Result<[Project], AppError>) -> Void) {
        NetworkHelper.manager.getData(from: airtableURL) { result in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let projects = try Project.getProjects(from: data)
                    completionHandler(.success(projects))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    // MARK: - Private Properties and Initializers
    
    private var airtableURL: URL {
        guard let url = URL(string: "https://api.airtable.com/v0/\(Secrets.APISubPath)/Design%20projects?typecast=true&&api_key=" + Secrets.APIKey) else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
