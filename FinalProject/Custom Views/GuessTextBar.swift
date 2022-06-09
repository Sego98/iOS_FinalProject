import Foundation
import UIKit
import SnapKit

class GuessTextBar: UIStackView {
    private var pencil: UIImageView!
    private var deny: UIButton!
    private var cancel: UIButton!
    private var stackView: UIStackView!
    private var type: UITextField!
    private var moviesTable: UITableView!
    
    static var inputText: String!
    
    private let searchBackground = UIColor(red: 217/255, green: 219/255, blue: 219/255, alpha: 1)
    
    private var barHeight: Int = 50
        
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
        
    init(){
        super.init(frame: .zero)
        
        pencil = UIImageView(image: UIImage(systemName: "pencil"))
        pencil.tintColor = .gray
        pencil.contentMode = .scaleAspectFit
        
        deny = UIButton()
        deny.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        deny.clipsToBounds = true
        deny.tintColor = .gray
        deny.addTarget(self, action: #selector(denyTapped), for: .touchUpInside)
        
        type = UITextField()
        type.backgroundColor = searchBackground
        type.placeholder = "Type my name"
        type.textAlignment = .left
        type.layer.cornerRadius = 15
        type.clipsToBounds = true
        type.adjustsFontSizeToFitWidth = true
        type.rightViewMode = .whileEditing
        type.rightView = deny
        type.leftViewMode = .always
        type.leftView = pencil
        type.delegate = self

        addMainConstraints()
        
        axis = .horizontal
        alignment = .leading
        distribution = .fill
        spacing = 20
        addArrangedSubview(type)
    }
}


extension GuessTextBar: UITextFieldDelegate{ //protocol funtions for search bar
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkText(textField: textField)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cancel = UIButton()
        cancel.backgroundColor = .clear
        let attributedTitle = NSMutableAttributedString(string: "Cancel")
        attributedTitle.addAttribute(.font, value: UIFont(name: "Arial", size: 20) as Any, range: NSRange(location: 0, length: "Cancel".count))
        cancel.setAttributedTitle(attributedTitle, for: .normal)
        cancel.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        addArrangedSubview(cancel)
        
        addSideConstraints()
 
        return true
    }
}

extension GuessTextBar{
    @objc func cancelTapped(){ //button cancel tapped
        type.resignFirstResponder()
        cancel.removeFromSuperview()
        type.text = ""
    }
    
    @objc func denyTapped(sender: UIButton!){ //button x tapped
        type.text = ""
    }
    
    func addMainConstraints() {
        pencil.snp.makeConstraints {
            $0.height.width.equalTo(barHeight-10)
        }
        
        type.snp.makeConstraints {
            $0.height.equalTo(barHeight)
        }
        
        deny.snp.makeConstraints {
            $0.height.width.equalTo(barHeight-20)
        }
    }
    
    func addSideConstraints() {
        cancel.snp.makeConstraints {
            $0.height.equalTo(barHeight)
        }
    }
    
    func checkText(textField: UITextField) {
        cancel.removeFromSuperview()
        if textField.text?.lowercased() == person.name?.lowercased() {
            if identifier < 4 {
                type.text = ""
                identifier += 1
                router.showCorrectAlert()
                print("Correct :)")
            }
            else {
                print("Correct :)")
                router.showFinishAlert()
            }
        }
        else {
            print("Wrong :(")
            router.showWrongAlert()
        }
    }
}
