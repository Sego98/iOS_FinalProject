import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var profileView : ProfileView!
    
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    private func buildViews() {
        initialize()
        addSubviews()
        addConstraints()
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func initialize(){
        view.backgroundColor = green
        scrollView = UIScrollView()
        contentView = UIView()
        let man = coreDataActions()
        profileView = ProfileView(name: man?.name ?? "", age: man?.age ?? 0, email: man?.mail ?? "", score: man?.score ?? 0, country: man?.country ?? "")
    }
    
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileView)
    }
    
    private func addConstraints(){
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        
        profileView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func coreDataActions() -> PersonData? {
        let coreData = CoreDataStack()
        let man = coreData.fetchPerson(withName: peopleNames[0])
        return man
    }
    
}
