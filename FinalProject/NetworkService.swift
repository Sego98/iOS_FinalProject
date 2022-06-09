import Foundation
import UIKit

class NetworkService {
    let baseImageURL = "https://image.tmdb.org/t/p/original"
    
    func executeUrlRequestSport(_ request: URLRequest, completionHandler: @escaping (Player?, RequestError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, .clientError)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                DispatchQueue.main.async {
                completionHandler(nil, .serverError)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, .noData)
                }
                return
            }
      
            guard let value = try? JSONDecoder().decode(Player.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(nil, .dataDecodingError)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(value, nil)
            }
        }
        dataTask.resume()
    }
    
    func executeUrlRequestMovie(_ request: URLRequest, completionHandler: @escaping (Actor?, RequestError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(nil, .clientError)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                DispatchQueue.main.async {
                completionHandler(nil, .serverError)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, .noData)
                }
                return
            }
      
            guard let value = try? JSONDecoder().decode(Actor.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(nil, .dataDecodingError)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(value, nil)
            }
        }
        dataTask.resume()
    }
    
    func makeRequest(urlString: String, type: String) {
        DispatchQueue.global(qos: .utility).async {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        switch type {
            case "Sport":
                self.executeUrlRequestSport(request){  stringValue, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let value = stringValue else {
                        return
                    }
                    person.name = value.players[0].strPlayer
                    person.profilePhoto = value.players[0].strCutout
                    DispatchQueue.main.async {
                        print(person.name!)
                        let url = URL(string: person.profilePhoto!)
                        let data = try? Data(contentsOf: url!)
                        GuessingViewController.personImage.image = UIImage(data: data!)
                    }    
                }
            
            case "Movies":
                self.executeUrlRequestMovie(request){ [self] stringValue, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let value = stringValue else {
                        return
                    }
                    person.name = value.name
                    person.profilePhoto = baseImageURL + value.profile_path!
                    DispatchQueue.main.async {
                        print(person.name!)
                        let url = URL(string: person.profilePhoto!)
                        let data = try? Data(contentsOf: url!)
                        GuessingViewController.personImage.image = UIImage(data: data!)
                    }
                }
                    
            case "Music":
                person.name = musicDict[musicID[identifier]]
                person.profilePhoto = urlString
            DispatchQueue.main.async {
                print(person.name!)
                let url = URL(string: person.profilePhoto!)
                let data = try? Data(contentsOf: url!)
                GuessingViewController.personImage.image = UIImage(data: data!)
            }
            
            case "Lifestyle":
                person.name = lifestyleDict[lifestyleID[identifier]]
                person.profilePhoto = urlString
            DispatchQueue.main.async {
                print(person.name!)
                let url = URL(string: person.profilePhoto!)
                let data = try? Data(contentsOf: url!)
                GuessingViewController.personImage.image = UIImage(data: data!)
            }
            default:
                fatalError()
        }
            
    }
}
}
