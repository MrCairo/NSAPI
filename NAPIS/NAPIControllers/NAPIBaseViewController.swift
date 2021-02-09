//
//  NAPIBaseViewController.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/27/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import UIKit

//public protocol NAPIViewControllerDelegate: class {
//    func didReceieveServiceResponse(success:Bool)
//}

class NAPIBaseViewController: UIViewController {

    var service: NAPIService? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        self.navigationItem.leftItemsSupplementBackButton = true
    }

}
