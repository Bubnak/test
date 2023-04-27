//
//  QuestionInteractorInterface.swift
//  WebService
//
//  Created by Bubna K on 28/10/22.
//

import Foundation

protocol QuestionInteractorInterface {
    var questionsPresenter: [QuestionPresenter] { get }
    var test: String {get set}
    func getTopQuestions(withCompletion completion: @escaping () -> Void)
}

