//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Lobe Musonda on 7/5/18.
//  Copyright © 2018 Lobe Musonda. All rights reserved.
//

//import Foundation
//
//protocol Endpoint {
//    var baseUrl: String { get }
//    var path: String {get}
//    var queryItems: [URLQueryItem] {get}
//}
//
//extension Endpoint {
//    var urlComponents: URLComponents {
//        var component = URLComponents(string: baseUrl)
//        component?.path = path
//        component?.queryItems = queryItems
//        
//        return component!
//    }
//    
//    var request: URLRequest {
//        return URLRequest(url: urlComponents.url!)
//    }
//}
//
//enum WeatherEndpoint: Endpoint {
//    case tenDayForecast(city: String, state: String)
//    var baseUrl: String {
//        return "http://api.apixu.com"
//    }
//    
//    var path: String {
//        switch self {
//        case .currentForecast(let city):
//            return "/v1/current.json?key=57592b9d9bda4fcc851180455180307&q=\(city)"
//        }
//    }
//    
//    var queryItems: [URLQueryItem] {
//        return []
//    }
//}
