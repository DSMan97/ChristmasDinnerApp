//
//  Repository.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 10/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func get(identifier:String) -> T?
    func get(name:String) -> T?
    func create(a: T) -> Bool
    func update(a: T) -> Bool
    func delete(a:T) ->Bool
}
