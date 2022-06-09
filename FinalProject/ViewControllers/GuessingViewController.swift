import Foundation
import UIKit
import SnapKit

class GuessingViewController: UIViewController  {
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var titleLabel: TitleLabel!
    private var profileButton: ProfileButton!
    private var scoreStack: ScoreStackView!
    static  var personImage: UIImageView!
    private var textBar: GuessTextBar!
    
    private var stackView: UIStackView!
    
    private let dimension = 80
    
    private var ids = [Int]()
    
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataActions()
        buildScreen()
        refreshPhoto()
        addConstraints()
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func buildScreen() {
        view.backgroundColor = yellow
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.backgroundColor = yellow
        scrollView.addSubview(contentView)
        
        titleLabel = TitleLabel(title: "WHO AM I?", fontSize: 38)
        
        scoreStack = ScoreStackView()
        
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(scoreStack)
        contentView.addSubview(stackView)
        
        GuessingViewController.personImage = UIImageView()
        GuessingViewController.personImage.contentMode = .scaleToFill
        contentView.addSubview(GuessingViewController.personImage)
        
        textBar = GuessTextBar(router: router)
        contentView.addSubview(textBar)
    }
    
    func refreshPhoto() {
        switch typeString {
            case "Sport":
                ids = sportID
            case "Movies":
                ids = movieID
            case "Music":
                ids = musicID
            case "Lifestyle":
                ids = lifestyleID
            default:
                fatalError()
        }
            
        let id = self.ids[identifier]
        let networkService = NetworkService()
            
        switch typeString {
            case "Sport":
                urlString = "https://www.thesportsdb.com/api/v1/json/2/lookupplayer.php?id=\(id)"
                    
            case "Movies":
                let apiKey = "d52b5d6006ac52a93e0c09485450af91"
                urlString = "https://api.themoviedb.org/3/person/\(id)?api_key=\(apiKey)&language=en-US"
                        
            case "Music":
                urlString = "https://celebritybucks.com/images/celebs/full/\(id).jpg"
            
            case "Lifestyle":
                urlString = "https://celebritybucks.com/images/celebs/full/\(id).jpg"
            
            default:
                fatalError()
        }
            
        networkService.makeRequest(urlString: urlString, type: typeString)
    }
    
    func coreDataActions() {
        let coreData = CoreDataStack()
        let man = coreData.fetchPerson(withName: peopleNames[0])
        score = man?.score ?? 0
    }
    
    func addConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        scoreStack.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(110)
        }
        
        GuessingViewController.personImage.snp.makeConstraints {
            $0.top.equalTo(scoreStack.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(GuessingViewController.personImage.snp.width)
        }
        
        textBar.snp.makeConstraints {
            $0.top.equalTo(GuessingViewController.personImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
