import Foundation
import UIKit
import SnapKit

class ProfileButton: UIButton{
    
    private let dimension: Int!
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(profileImage: UIImage, dimension: Int){
        self.dimension = dimension
        super.init(frame: .zero)
        
        setImage(profileImage, for: .normal)
        imageView?.contentMode = .scaleToFill
        imageView?.clipsToBounds = true
        backgroundColor = .clear
        tintColor = .black
        addConstraints()
    }
    
    private func addConstraints(){
        self.imageView!.snp.makeConstraints {
            $0.width.height.equalTo(dimension)
        }
    }
}
