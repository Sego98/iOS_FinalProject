import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let dimension: Int = 80
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var headerView: UIView!
    private var profileButton: UIButton!
    private var titleLabel: UILabel!
    private var multilineLabel: UILabel!
    private var chooseCategory: UILabel!
    private var categoryCollection: CategoriesCollectionView!
    
    private let images = ["tv.circle", "play.circle", "music.mic", "globe.europe.africa.fill"]
    private var names = ["Sport", "Movies", "Music", "Lifestyle"]
    
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildScreen()
        addConstraints()
        coreDataActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sportID.shuffle()
        movieID.shuffle()
        musicID.shuffle()
        lifestyleID.shuffle()
        identifier = 0
        person.name = ""
        person.profilePhoto = ""
    }
    
    func buildScreen(){
        self.navigationItem.title =  "The best quiz ever"
        view.backgroundColor = green
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.backgroundColor = green
        scrollView.addSubview(contentView)
        
        headerView = UIView()
        headerView.backgroundColor = yellow
        headerView.layer.cornerRadius = 30
        contentView.addSubview(headerView)
        
        profileButton = ProfileButton(profileImage: UIImage(systemName: "brain.head.profile")!, dimension: dimension)
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        headerView.addSubview(profileButton)
        
        titleLabel = TitleLabel(title: "CELEBS QUIZ", fontSize: 38)
        headerView.addSubview(titleLabel)
        
        multilineLabel = MultilineLabel(text: "Hello and welcome to the best celebrities quiz you have ever seen!  We will present you a picture of a celebrity and you need to write his/her name in the text field. Just make sure you don't have any typing mistakes. It's that simple :)")
        contentView.addSubview(multilineLabel)
        
        chooseCategory = TitleLabel(title: "CHOOSE CATEGORY", fontSize: 34)
        contentView.addSubview(chooseCategory)
        
        categoryCollection = CategoriesCollectionView()
        categoryCollection.backgroundColor = green
        categoryCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        contentView.addSubview(categoryCollection)
    }
    
    @objc func profileTapped() {
        router.pushProfileVC()
    }
    
    func addConstraints(){
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.snp.bottom)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(dimension + 15)
        }
        
        profileButton.snp.makeConstraints {
            $0.width.height.equalTo(dimension)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(dimension)
            $0.trailing.equalTo(profileButton.snp.leading)
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(30)
        }
        
        multilineLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        chooseCategory.snp.makeConstraints {
            $0.top.equalTo(multilineLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        categoryCollection.snp.makeConstraints {
            $0.top.equalTo(chooseCategory.snp.bottom).offset(20)
            $0.height.equalTo(450)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func coreDataActions() {
        let coreData = CoreDataStack()
        coreData.deleteAllPeople()
        coreData.savePeople()
        coreData.savePerson(name: "Ivan Barać", country: "Croatia", mail: "ivan.barac@gmail.com", age: 24, score: 256)
        peopleNames.append("Ivan Barać")
        coreData.savePerson(name: "Nikola Tomažin", country: "Croatia", mail: "nikola.tomazin@fer.hr", age: 25, score: 185)
        peopleNames.append("Nikola Tomažin")
        peopleNames.shuffle()
        let results = coreData.fetchAllPeople()
        for res in results {
            print(res.name!)
        }
        print("")
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as? CollectionViewCell
                
        else{
            fatalError()
        }
        cell.configure(image: UIImage(systemName: images[indexPath.section])!, title: names[indexPath.section])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section{
            case 0:
                typeString = "Sport"
            case 1:
                typeString = "Movies"
            case 2:
                typeString = "Music"
            case 3:
                typeString = "Lifestyle"
            default:
                fatalError()
        }
        router.pushGuessingVC()
    }
}
