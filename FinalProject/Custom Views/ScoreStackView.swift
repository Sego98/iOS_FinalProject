import Foundation
import UIKit
import SnapKit

class ScoreStackView: UIStackView {
    var fireImage: UIImageView!
    var points: TitleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        axis = .horizontal
        alignment = .leading
        distribution = .fillProportionally
        spacing = 10
        backgroundColor = .clear
        
        fireImage = UIImageView(image: UIImage(systemName: "flame.fill")!)
        fireImage.tintColor = .red
        fireImage.contentMode = .scaleToFill
        
        addArrangedSubview(fireImage)
        
        points = TitleLabel(title: String(score!), fontSize: 30)
        points.textColor = .red
        addArrangedSubview(points)
        
        addConstraints()
    }
    
    private func addConstraints() {
        fireImage.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
    }
}
