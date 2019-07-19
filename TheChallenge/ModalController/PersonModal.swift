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
        changeGroups()
        save(people: people)
    }
    //Delete
    func delete(name: String, completion: (Bool) -> Void){
        guard let index = people.firstIndex(of: name) else {return}
        people.remove(at: index)
        changeGroups()
        save(people: people)
        completion(true)
    }
    //Randomize
    func randomize(){
        people = people.shuffled()
        changeGroups()
        save(people: people)
    }
    //Create Groups
    func changeGroups(){
        //getting how far we have gon through the
        var count = 0
        var currentGroup = 0
        groups = [[]]
        while count < people.count{
            if groups[currentGroup].count > 1{
                groups.append([])
                currentGroup += 1
            } else {
                groups[currentGroup].append(people[count])
                count += 1
            }
        }
    }
    //sets the file path we are using
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "PeopleList.json"
        let fullURL = documentDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    //saves to Persistance
    func save(people: [String]){
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(people)
            try data.write(to: fileURL())
        }catch let error {
            print(error.localizedDescription)
        }
    }
    //Loads from Persistance
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
