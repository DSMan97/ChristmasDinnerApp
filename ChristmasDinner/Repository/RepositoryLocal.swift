//
//  RepositoryLocal.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 10/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import Foundation
import RealmSwift

class RepositoryLocalParticipant: Repository{
    
    func getAll() -> [Participant]{
        var participants: [Participant] = []
        
        do {
            let entities = try Realm().objects(Participants.self).sorted(byKeyPath: "assistDate", ascending: false)
            
            for entity in entities {
                let model = entity.participantModel()
                participants.append(model)
            }
        }
        catch let error as NSError {
            print("ERROR getAll Participants: ", error.description)
        }
        
        return participants
    }
    
    func get(identifier:String) -> Participant?{
        do {
            let realm = try! Realm()
            if let entity = realm.objects(Participants.self).filter("id == %@",identifier).first {
                 let model = entity.participantModel()
                return model
            }
            
        }
        return nil
    }
    func get(name:String) -> Participant?{
        do {
            let realm = try! Realm()
            if let entity = realm.objects(Participants.self).filter("name == %@",name).first {
                 let model = entity.participantModel()
                return model
            }
            
        }
        return nil
    }
    func create(a:Participant) -> Bool {
        do {
            let realm = try! Realm()
           
            let entity = Participants(id: a.id, name: a.name, assistDate: a.assistDate, paidState: a.paidState)
            try realm.write {
               
                realm.add(entity, update: true)
            }
            
        } catch {
            return false
        }
        return true
    }
    
    func delete(a:Participant) ->Bool {
        do{
            let realm = try Realm()
            try realm.write {
                let entryToDelete = realm.objects(Participants.self).filter("id == %@", a.id)
                realm.delete(entryToDelete)
            }
        }
        catch {
            return false
        }
        
        return true
    }
    
    func update(a: Participant) -> Bool {
      
        return create(a: a)
    }
    
}
