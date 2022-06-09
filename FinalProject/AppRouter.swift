import Foundation
import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window: UIWindow?)
    func pushProfileVC()
    func pushGuessingVC()
    func pushFinishVC()
    func popToRootVC()
    func showCorrectAlert()
    func showWrongAlert()
    func showFinishAlert()
}

class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = HomeViewController(router: self)
        //let vc = FinishViewController(router: self)
        navigationController.pushViewController(vc, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func pushProfileVC() {
        let vc = ProfileViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushGuessingVC() {
        let vc = GuessingViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushFinishVC() {
        let vc = FinishViewController(router: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popToRootVC() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showCorrectAlert() {
        let dialogMessage = UIAlertController(title: "CORRECT", message: "You're right, my name is \(person.name!).", preferredStyle: .alert)
        dialogMessage.view.tintColor = darkGreen
        let continueButton = UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            let guessingVC = GuessingViewController()
            guessingVC.refreshPhoto()
         })
        dialogMessage.addAction(continueButton)
        navigationController.present(dialogMessage, animated: true, completion: nil)
    }
    
    func showWrongAlert() {
        let dialogMessage = UIAlertController(title: "WRONG", message: "Hmm, that's wrong. Let's try again.", preferredStyle: .alert)
        dialogMessage.view.tintColor = .red
        let againButton = UIAlertAction(title: "Try again", style: .default, handler: { (action) -> Void in
         })
        dialogMessage.addAction(againButton)
        navigationController.present(dialogMessage, animated: true, completion: nil)
    }
    
    func showFinishAlert() {
        let dialogMessage = UIAlertController(title: "CORRECT", message: "You're right, my name is \(person.name!). Let's finish this quiz!", preferredStyle: .alert)
        dialogMessage.view.tintColor = .systemBlue
        let againButton = UIAlertAction(title: "Finish", style: .default, handler: { (action) -> Void in
            self.pushFinishVC()
         })
        dialogMessage.addAction(againButton)
        navigationController.present(dialogMessage, animated: true, completion: nil)
    }
}
