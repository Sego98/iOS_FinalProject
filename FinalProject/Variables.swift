import Foundation
import UIKit

public var identifier = 0

public var sportID = [34146370, 34153733, 34166857, 34162284, 34161176]
public var movieID = [976, 11701, 72129, 1136406, 85]
public var musicID = [8563, 8520, 3926, 2488, 8559]
public var lifestyleID = [9623, 8914, 4854, 8906,  8374]

public var musicDict: [Int : String] = [8563 : "Michael Jackson", 8520 : "Lady Gaga", 3926 : "Jennifer Lopez", 2488 : "Eminem", 8559 : "Justin Bieber"]
public var lifestyleDict: [Int : String] = [9623 : "Meghan Markle", 8914 : "Michael Jordan", 4854 : "Kim Kardashian", 8906 : "Donald Trump", 8374 : "Will Smith"]

public let red = UIColor(red: 247/255, green: 79/255, blue: 49/255, alpha: 1)
public let green = UIColor(red: 170/255, green: 240/255, blue: 225/255, alpha: 1)
public let yellow = UIColor(red: 219/255, green: 170/255, blue: 44/255, alpha: 1)
public let darkGreen = UIColor(red: 13/255, green: 168/255, blue: 47/255, alpha: 1)

public enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

public struct Sportsman: Codable {
    let strPlayer: String?
    let strCutout: String?
}

public struct Player: Codable {
    let players: [Sportsman]
}

public struct Actor: Codable {
    let name: String?
    let profile_path: String?
}

public struct Person {
    var name: String?
    var profilePhoto: String?
}

public var person = Person(name: "", profilePhoto: "")
public var typeString: String = ""
public var urlString: String = ""
public var score: Int16? = 0

public var peopleDictArray : [[String : Any]] = [[ : ]]

let lukaMacan = ["name" : "Luka Macan",
                 "age" : 24,
                 "country" : "Croatia",
                 "mail" : "luka.macan@gmail.com",
                 "score" : 154
] as [String : Any]
let petarLjubotina = ["name" : "Petar Ljubotina",
                      "age" : 23,
                      "country" : "Estonia",
                      "mail" : "petar.ljubotina@fer.hr",
                      "score" : 136
] as [String : Any]

public var peopleNames = ["Petar Ljubotina", "Luka Macan"]




