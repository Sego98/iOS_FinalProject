//
//  PersonData+CoreDataProperties.swift
//  FinalProject
//
//  Created by Petar Ljubotina on 09.06.2022..
//
//

import Foundation
import CoreData


extension PersonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonData> {
        return NSFetchRequest<PersonData>(entityName: "PersonData")
    }

    @NSManaged public var age: Int16
    @NSManaged public var country: String?
    @NSManaged public var mail: String?
    @NSManaged public var name: String?
    @NSManaged public var score: Int16

}

extension PersonData : Identifiable {

}
