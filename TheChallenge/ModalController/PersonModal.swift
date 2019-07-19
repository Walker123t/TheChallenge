//
//  PersonModal.swift
//  TheChallenge
//
//  Created by Trevor Walker on 7/19/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import Foundation
class PersonController{
    
    static let shared = PersonController()
    var people: [String] = []
    var groups: [[String]] = []
    
    //Add
    func add(name: String){
        people.append(name)
        save(people: people)
    }
    //Delete
    func delete(name: String){
        guard let index = people.firstIndex(of: name) else {return}
        people.remove(at: index)
        save(people: people)
    }
    //Randomize
    func randomize(){
        people = people.shuffled()
        save(people: people)
    }
    func changeGroups(){
        var counter = 1
        var index = 0
        var currentGroup: [String] = []
        
        while index <= (people.count - 1) {
            if counter <= 2{
                counter += 1
                currentGroup.append(people[index])
                index += 1
            } else {
                groups.append(currentGroup)
                counter = 1
                currentGroup = []
            }
        }
    }
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "PeopleList.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
    func save(people: [String]){
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(people)
            try data.write(to: fileURL())
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadPeople() -> [String]?{
        let jsonDecoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: fileURL())
            let people = try jsonDecoder.decode([String].self, from: data)
            return people
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
