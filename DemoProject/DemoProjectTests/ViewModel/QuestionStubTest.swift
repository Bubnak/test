//
//  QuestionInteractorMock.swift
//  APIStudyTests
//
//  Created by Bubna K on 3/12/22.
//

import Foundation


class QuestionStubTest: QuestionInteractorInterface {
    var test2: String = ""
    var test: String {
        get {return ""}
        set {test2 = newValue}
    }
    
    var questionsPresenter: [QuestionPresenter] = []
   // let dataManager = QuestionsDataManager()
    func getTopQuestions(withCompletion completion: @escaping () -> Void) {
        guard let url = Bundle(for: QuestionStubTest.self).url(forResource: "auth-success-response", withExtension: "json"),
                     let data = try? Data(contentsOf: url)
               else {
                   return completion()
               }
        let wrapper = try? JSONDecoder().decode(Wrapper<Movie>.self, from: data)
        if let questions = wrapper?.Search {
            for question in questions {
                let question = QuestionPresenter(title: question.Title, descript: question.Poster)
                self.questionsPresenter.append(question)
            }
            completion()
        }
        
     }
    
  
}


