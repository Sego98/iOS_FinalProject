import Foundation
import UIKit
import SnapKit

class ProfileView: UIView{

    private var name : String!
    private var age : Int16!
    private var email : String!
    private var score : Int16!
    private var country : String!
    private var stackView: UIStackView!
    private var titleLabel: UILabel!
    private var nameLabel: UILabel!
    private var backGround : UIView!
    private var starImage: UIImage!
    private var imagePicView: UIImageView!
    private var imageView: UIView!
    private var deleteButton: UIButton!
    private var deleteLabel: UILabel!
    private var logoutButton: UIButton!
    private var logoutLabel: UILabel!
    private var fieldView1: FieldView!
    private var fieldView2: FieldView!
    private var fieldView3: FieldView!
    private var fieldView4: FieldView!
    
    init(name: String, age: Int16, email: String, score: Int16, country: String) {
        super.init(frame: .zero)
        self.name = name
        self.age = age
        self.email = email
        self.score = score
        self.country = country
        buildViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews(){
        createViews()
        addSubviews()
        styleViews()
        addConstraints()
    }
    
    private func createViews(){
        titleLabel = UILabel()
        nameLabel = UILabel()
        backGround = UIView()
        stackView = UIStackView()
        deleteButton = UIButton()
        deleteLabel = UILabel()
        logoutButton = UIButton()
        logoutLabel = UILabel()
        fieldView1 = FieldView(key: "Age:", value: String(age))
        fieldView2 = FieldView(key: "E-mail:", value: email)
        fieldView3 = FieldView(key: "Country:", value: country)
        fieldView4 = FieldView(key: "High score:", value: String(score))
        
        starImage = UIImage(named: "v3_0625420.jpeg")
        imagePicView = UIImageView(image: starImage)
        imageView = UIView()
    }
    
    private func addSubviews(){
        addSubview(titleLabel)
        addSubview(backGround)
        backGround.addSubview(nameLabel)
        backGround.addSubview(imageView)
        backGround.addSubview(deleteButton)
        backGround.addSubview(deleteLabel)
        backGround.addSubview(logoutButton)
        backGround.addSubview(logoutLabel)

        backGround.addSubview(stackView)

        stackView.addArrangedSubview(fieldView1)
        stackView.addArrangedSubview(fieldView2)
        stackView.addArrangedSubview(fieldView3)
        stackView.addArrangedSubview(fieldView4)
        imageView.addSubview(imagePicView)
    }
    
    private func styleViews(){
        titleLabel.text = "Profile"
        nameLabel.text = name
        deleteLabel.text = "Delete account"
        logoutLabel.text = "Log out"
        let font1 = UIFont(name: "Copperplate", size: 20)!
        let font2 = UIFont(name: "Copperplate", size: 30)!
        let font3 = UIFont(name: "Copperplate", size: 25)!
        deleteLabel.textColor = .red
        deleteLabel.font = font1
        logoutLabel.textColor = .red
        logoutLabel.font = font1
        
        titleLabel.font = font2
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldSearch = UIImage(systemName: "trash", withConfiguration: boldConfig)
        
        let boldConfig2 = UIImage.SymbolConfiguration(weight: .bold)
        let boldSearch2 = UIImage(systemName: "multiply.circle.fill", withConfiguration: boldConfig2)

        deleteButton.setImage(boldSearch, for: .normal)
        deleteButton.tintColor = .red
        logoutButton.setImage(boldSearch2, for: .normal)
        logoutButton.tintColor = .red
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 50
        imagePicView.layer.cornerRadius = 50
        imagePicView.layer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.6).cgColor
        imagePicView.clipsToBounds = true
        imagePicView.layer.masksToBounds = true
        imagePicView.tintColor = .white
        let skyBlue = UIColor(red: 0.4627, green: 0.8392, blue: 1.0,alpha: 0.6).cgColor
        backGround.layer.backgroundColor = skyBlue
        titleLabel.textAlignment = .center;
        nameLabel.font = font3
        nameLabel.textAlignment = .center;
        nameLabel.numberOfLines = 0
    }
    
    private func addConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
        }

        backGround.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(imageView.snp.trailing).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
        
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(100)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.top.equalToSuperview().inset(20)
        }
        
        imagePicView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        deleteButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        deleteLabel.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(40)
            $0.leading.equalTo(deleteButton.snp.trailing).offset(8)
        }
        
        logoutButton.snp.makeConstraints{
            $0.top.equalTo(deleteButton.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(20)
        }
        
        logoutLabel.snp.makeConstraints{
            $0.top.equalTo(deleteLabel.snp.bottom).offset(40)
            $0.leading.equalTo(logoutButton.snp.trailing).offset(8)
        }
    }
}

