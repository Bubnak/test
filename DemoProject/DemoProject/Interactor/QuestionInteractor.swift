//
//  QuestionViewModel.swift
//  WebService
//
//  Created by Bubna K on 26/6/22.
//

import Foundation
import UIKit

class QuestionInteractor: QuestionInteractorInterface {
    var test: String {
        get { return  ""}
        set {}
    }
    
    var questionsPresenter = [QuestionPresenter]()
   // let dataManager = QuestionsDataManager()
    private(set) var isLoading = false
    
     func getTopQuestions(withCompletion completion: @escaping () -> Void) {
         guard !isLoading else { return }
         isLoading = true
        
         QuestionsDataManager.shared.fetchTopQuestions {[weak self] questions in
             self?.isLoading = false
             if let questions = questions {
                 for question in questions {
                     let question = QuestionPresenter(title: question.Title, descript: question.Poster)
                     self?.questionsPresenter.append(question)
                 }
             }
             completion()
         }
    }
    
    
}
