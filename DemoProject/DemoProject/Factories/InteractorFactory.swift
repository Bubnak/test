//
//  InteractorFactory.swift
//  APIStudy
//
//  Created by Bubna K on 2/12/22.
//

import Foundation

class InteractorFactory {
    
    static func create() -> QuestionInteractorInterface {
        let enviromment = ProcessInfo.processInfo.environment["ENV"]
        if enviromment == "TEST" {
            return QuestionStubTest()
        } else {
            return QuestionInteractor()
        }
    }
    
}
