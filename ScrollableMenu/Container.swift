//
//  Container.swift
//  ScrollableMenu
//
//  Created by Saleh Masum on 5/9/2022.
//

import Foundation
import UIKit

/*
 Container holding child view controllers. Sits under the menubar
*/

class Container: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
