import Foundation
import UIKit
import CoreData

class CoreDataStack {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func savePerson(name: String, country: String, mail: String, age: Int16, score: Int16) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PersonData", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKey: "name")
        person.setValue(country, forKey: "country")
        person.setValue(mail, forKey: "mail")
        person.setValue(age, forKey: "age")
        person.setValue(score, forKey: "score")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save, because there is an error \(error).")
        }
    }
    
    func fetchPerson(withName name: String) -> PersonData? {
        let request: NSFetchRequest<PersonData> = PersonData.fetchRequest()
        let managedContext = persistentContainer.viewContext
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(PersonData.name), name)
        do{
            let results = try managedContext.fetch(request)
            return results.first
        } catch let error as NSError{
            print(error)
            return nil
        }
    }
    
    func savePeople() {
        //.plist file doesn't work so I used normal dictionary
        
        peopleDictArray.append(petarLjubotina)
        peopleDictArray.append(lukaMacan)
        
        let managedContext = persistentContainer.viewContext
        let fetch: NSFetchRequest<PersonData> = PersonData.fetchRequest()
        guard
            let count = try? managedContext.count(for: fetch),
            count == 0
        else {
            return
        }
        
        let dataArray = NSArray(array: peopleDictArray)
        for i in 1...dataArray.count - 1 {
            let dict = dataArray[i]
            let btDict = dict as! [String : Any]
            let entity = NSEntityDescription.entity(forEntityName: "PersonData", in: managedContext)!
            let person = PersonData(entity: entity, insertInto: managedContext)
 
            if
                let age = btDict["age"] as? Int,
                let country = btDict["country"] as? String,
                let mail = btDict["mail"] as? String,
                let name = btDict["name"] as? String,
                let score = btDict["score"] as? Int
            {
                person.age = Int16(age)
                person.country = country
                person.mail = mail
                person.name = name
                person.score = Int16(score)
            }
         }
        try? managedContext.save()
    }
    
    func fetchAllPeople() -> [PersonData] {
        let managedContext = persistentContainer.viewContext
        let request: NSFetchRequest<PersonData> = PersonData.fetchRequest()
        do {
            let results = try managedContext.fetch(request)
            return results
        } catch let error as NSError {
            print("Error \(error)")
            return []
        }
    }
    
    func deleteAllPeople() {
        let context = persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}
