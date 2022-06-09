import Foundation
import UIKit
import SnapKit

class FieldView: UIView{
    private var key : String?
    private var value : String?
    private var keyLabel: UILabel!
    private var valueLabel: UILabel!
    
    init(key: String, value: String) {
        super.init(frame: .zero)
        self.key = key
        self.value = value
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
        keyLabel = UILabel()
        valueLabel = UILabel()
    }
    
    private func addSubviews(){
        addSubview(keyLabel)
        addSubview(valueLabel)
    }
    
    private func styleViews(){
        keyLabel.text = key
        valueLabel.text = value
        keyLabel.textAlignment = .left
        valueLabel.textAlignment = .center
        let font = UIFont(name: "Copperplate", size: 20)!
        keyLabel.font = font
        valueLabel.layer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.15).cgColor
        let font2 = UIFont(name: "Copperplate-Bold", size: 20)!
        valueLabel.font = font2
    }
    
    private func addConstraints() {
        
        keyLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        valueLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(keyLabel.snp.bottom).offset(10)
        }
    }
}
