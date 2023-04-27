//
//  QuestionsModel.swift
//  TopQuestions
//
//  Created by Matteo Manferdini on 04/02/21.
//

import Foundation


class QuestionsDataManager {
    static let shared = QuestionsDataManager()
    private init() {}
    
    private(set) var questions: [Movie]? = []
	private var request: APIRequest<QuestionsResource>?
    private var imageRequest: ImageRequest?
    
	func fetchTopQuestions(withCompletion completion: @escaping ([Movie]?) -> Void) {
		let resource = QuestionsResource()
		let request = APIRequest(resource: resource)
		self.request = request
		request.execute { [weak self] (questions, _) in
			self?.questions = questions ?? []
            completion(questions)
		}
	}
}

 

// MARK: - QuestionsResource
struct QuestionsResource: APIResource {
    var filter: String?
    typealias ModelType = Movie
    var id: Int?
    
    var methodPath: String {
        return ""
    }
    
    var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: "b9bd48a6"),
            URLQueryItem(name: "s", value: "Marvel"),
            URLQueryItem(name: "type", value: "movie")
           
        ]
   
    
    var parameters: [String : Any]? = [:]
}
