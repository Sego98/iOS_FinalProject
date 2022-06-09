import Foundation
import UIKit
import SnapKit

class FinishViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var endGameView : EndGameView!
    
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        endGameView.addDinamicConstraints()
        UIView.animate(withDuration: 1, delay: 0, options:.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil) 
    }
    
    private func buildViews() {
        initialize()
        addSubviews()
        addConstraints()
    }
    
    private func initialize(){
        view.backgroundColor = red
        scrollView = UIScrollView()
        contentView = UIView()
        endGameView = EndGameView(score: "100", router: router)
    }
    
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(contentView)
        contentView.addSubview(endGameView)
    }
    
    private func addConstraints(){
        
       scrollView.snp.makeConstraints {
           $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
           $0.bottom.equalTo(view.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }
        
        endGameView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
