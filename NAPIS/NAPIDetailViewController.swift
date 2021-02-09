//
//  NAPIDetailViewController.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/28/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import UIKit

class NAPIDetailViewController: UIViewController {
    public fileprivate(set) var service:NAPIService?

    fileprivate var activeStoryboard:UIStoryboard?
    fileprivate var activeViewController:UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupService() {
        if let service = service {
            if let _ = activeViewController {
                activeViewController?.view.removeFromSuperview()
                activeViewController?.removeFromParent()
            }
            activeStoryboard = UIStoryboard(name: service.storyboard, bundle: nil)
            activeViewController = activeStoryboard?.instantiateInitialViewController()

            if let active = activeViewController {
                active.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                active.navigationItem.leftItemsSupplementBackButton = true
            }

            if let embedded = activeViewController {
                addChild(embedded)
                embedded.didMove(toParent: self)
                self.view.addSubview(embedded.view)
                self.view.centerXAnchor.constraint(equalTo: embedded.view.centerXAnchor).isActive = true
                self.view.centerYAnchor.constraint(equalTo: embedded.view.centerYAnchor).isActive = true
                self.view.heightAnchor.constraint(equalTo: embedded.view.heightAnchor).isActive = true
                self.view.widthAnchor.constraint(equalTo: embedded.view.widthAnchor).isActive = true
            }
        }
    }
}


extension NAPIDetailViewController: NAPIServiceDelegate {
    func selectedService(_ newService: NAPIService) {
        service = newService
        setupService()
    }
}
