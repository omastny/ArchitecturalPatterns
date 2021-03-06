//
//  PersonsInteractor.swift
//  cleanSwift_example
//
//  Created by Oliver Mastny on 06/01/2017.
//  Copyright (c) 2017 Oliver Mastny. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol PersonsInteractorInput {
    func updateView()
    var persons: [Person]? { get }
}

protocol PersonsInteractorOutput {
    func show(response: Persons.FetchPersons.Response)
    func personsRemoved()
}

class PersonsInteractor: PersonsInteractorInput {
    var output: PersonsInteractorOutput!
    var personsWorker = PersonsWorker()
    
    var persons: [Person]?
    
    func updateView() {
        personsWorker.getPersons { persons in
            self.persons = persons
            let response = Persons.FetchPersons.Response(persons: persons)
            self.output.show(response: response)
        }
    }
    
    func removePersons() {
        personsWorker.removePersons()
        output.personsRemoved()
    }
}
