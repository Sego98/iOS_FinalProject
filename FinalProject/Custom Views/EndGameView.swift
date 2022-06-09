import Foundation
import UIKit
import SnapKit

class EndGameView: UIView{
    private var Score : String?
    private var backGround : UIView!
    private var finishButton : UIButton!
    private var owlImage: UIImage!
    private var imagePicView: UIImageView!
    private var scoreLabel: UILabel!
    private var rangLabel: UILabel!
    
    private var router: AppRouterProtocol!

    init(score: String, router: AppRouterProtocol) {
        self.Score = score
        self.router = router
        super.init(frame: .zero)
        buildViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews(){
        createViews()
        addSubviews()
        styleViews()
        addStaticConstraints()
    }
    
    private func createViews(){
        backGround = UIView()
        finishButton = UIButton()
        owlImage = UIImage(named: "Sitting")
        imagePicView = UIImageView(image: owlImage)
        rangLabel = UILabel()
        scoreLabel = UILabel()
        }
    
    private func addSubviews(){
        addSubview(backGround)
        backGround.addSubview(imagePicView)
        backGround.addSubview(finishButton)
        backGround.addSubview(scoreLabel)
        backGround.addSubview(rangLabel)
    }
    
    private func styleViews(){
        let font = UIFont(name: "Copperplate", size: 20)!
        
        finishButton.setTitle("Finish", for: .normal)
        finishButton.layer.backgroundColor = green.cgColor
        finishButton.layer.cornerRadius = 20
        finishButton.titleLabel?.font = font
        finishButton.setTitleColor(.black, for: .normal)
        finishButton.addTarget(self, action: #selector(finishTapped), for: .touchUpInside)
        finishButton.isHidden = true
        
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: \(self.Score!)"
        scoreLabel.font = font
        scoreLabel.layer.backgroundColor = green.cgColor
        scoreLabel.layer.cornerRadius = 20
        scoreLabel.isHidden = true
        
        rangLabel.textAlignment = .center
        rangLabel.text = "Rang: 120"
        rangLabel.font = font
        rangLabel.layer.backgroundColor = green.cgColor
        rangLabel.layer.cornerRadius = 20
        rangLabel.isHidden = true
    }
    
    private func addStaticConstraints(){
     
        backGround.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imagePicView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
        }    
    }
    
    func addDinamicConstraints() {
        rangLabel.isHidden = false
        scoreLabel.isHidden = false
        finishButton.isHidden = false
         
        scoreLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.top.equalTo(imagePicView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        rangLabel.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.top.equalTo(scoreLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        finishButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.top.equalTo(rangLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func finishTapped() {
        router.popToRootVC()
    }
}

