import Foundation
import UIKit
import SnapKit

class CategoriesCollectionView : UICollectionView{
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(){
        //create layout for CollectionView
        let flowLayout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 350, height: 100)
        
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    }
}
