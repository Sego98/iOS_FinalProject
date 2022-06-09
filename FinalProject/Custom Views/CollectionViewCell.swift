import Foundation
import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell{
    private var myImage: UIImageView!
    private var titleLabel: UILabel!
    private var cellView: UIView!
    private var cornerRadius: CGFloat = 40
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
        addConstraints()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCell() {
        cellView = UIView()
        cellView.backgroundColor = yellow
        cellView.layer.cornerRadius = cornerRadius
        cellView.layer.masksToBounds = true
        contentView.addSubview(cellView)

        myImage = UIImageView()
        myImage.clipsToBounds = true
        myImage.contentMode = .scaleToFill
        myImage.layer.masksToBounds = true
        myImage.tintColor = .black
        cellView.addSubview(myImage)
        
        titleLabel = TitleLabel(title: " ", fontSize: 45)
        cellView.addSubview(titleLabel)
    }
    
    public func configure(image: UIImage, title: String){
        myImage.image = image
        titleLabel.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImage.image = nil
        titleLabel.attributedText = nil
    }
    
    //cell constraints
    func addConstraints(){
        cellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myImage.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalTo(myImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
    }
}
