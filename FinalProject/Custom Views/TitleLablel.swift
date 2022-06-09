import Foundation
import UIKit

class TitleLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(title: String, fontSize: Int){
        super.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(string: title)
        attributedTitle.addAttribute(.font, value: UIFont(name: "ArialRoundedMTBold", size: CGFloat(fontSize)) as Any, range: NSRange(location: 0, length: title.count))
        attributedText = attributedTitle
        backgroundColor = .clear
        textAlignment = .center
        sizeToFit()
    }
}
