import Foundation
import UIKit

class MultilineLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(text: String){
        super.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(string: text)
        attributedTitle.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: 20) as Any, range: NSRange(location: 0, length: text.count))
        attributedText = attributedTitle
        backgroundColor = .clear
        textAlignment = .left
        numberOfLines = 0
        sizeToFit()
    }
}
