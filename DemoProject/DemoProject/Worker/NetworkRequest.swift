//
//  NetworkRequest.swift
//  TopQuestion
//
//  Created by Matteo Manferdini on 12/09/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation
//import UIKit

// MARK: - NetworkRequest
protocol NetworkRequest: AnyObject {
	associatedtype ModelType
	func decode(_ data: Data) -> ModelType?
	func execute(withCompletion completion: @escaping (ModelType?, Error?) -> Void)
}

enum HttpMethod: String{
   case get = "GET"
   case post = "POST"
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, parametrs:[String: Any]?, httpMethod:String, withCompletion completion: @escaping (ModelType?, Error?) -> Void) {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 20
		let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response , error) -> Void in
            
            guard let data = data, let value = self?.decode(data), let httpResponse = response as? HTTPURLResponse, error == nil else {
                    print("No valid response")
                DispatchQueue.main.async { completion(nil, error) }
                    return
                }

                guard 200 ..< 300 ~= httpResponse.statusCode else {
                    let error = NSError(domain: httpResponse.description, code: httpResponse.statusCode)
                    DispatchQueue.main.async { completion(nil, error) }
                    print("Status code was \(httpResponse.statusCode), but expected 2xx")
                    return
                }
//			guard let data = data, let value = self?.decode(data) else {
//                DispatchQueue.main.async { completion(nil, nil) }
//				return
//			}
            DispatchQueue.main.async { completion(value, nil) }
		}
		task.resume()
	}
}

// MARK: - ImageRequest
class ImageRequest {
	let url: URL
	
	init(url: URL) {
		self.url = url
	}
}

extension ImageRequest: NetworkRequest {
	func decode(_ data: Data) -> Data? {
		
        return data
	}
	
	func execute(withCompletion completion: @escaping (Data?, Error?) -> Void) {
        load(url, parametrs: nil, httpMethod: HttpMethod.get.rawValue, withCompletion: completion)
	}
}

// MARK: - APIRequest
class APIRequest<Resource: APIResource> {
	let resource: Resource
	
	init(resource: Resource) {
		self.resource = resource
	}
}

extension APIRequest: NetworkRequest {
    
	func decode(_ data: Data) -> [Resource.ModelType]? {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
		return wrapper?.Search
	}
	
	func execute(withCompletion completion: @escaping ([Resource.ModelType]?, Error?) -> Void) {
        load(resource.url, parametrs: resource.parameters, httpMethod: HttpMethod.get.rawValue, withCompletion: completion)
	}
}

// MARK: - Wrapper
struct Wrapper<T: Decodable>: Decodable {
    let Search :[T]
}


// MARK: - APIResource
protocol APIResource {
	associatedtype ModelType: Decodable
	var methodPath: String { get }
	var filter: String? { get }
    var queryItems: [URLQueryItem] { get }
    var parameters: [String: Any]? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string:baseUrl)!
        components.path = methodPath
        components.queryItems = queryItems
        return components.url!
    }
}


