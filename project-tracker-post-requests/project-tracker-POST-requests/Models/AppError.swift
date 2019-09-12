//
//  AppError.swift
//  project-tracker-POST-requests
//
//  Created by Sunni Tang on 9/12/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
