//
//  SplitViewDelegate.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/27/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import UIKit

class SplitViewDelegate: NSObject, UISplitViewControllerDelegate {
    
    func splitViewController(_ svc: UISplitViewController,
                             willShow vc: UIViewController,
                             invalidating barButtonItem: UIBarButtonItem) {
        if let detailView = svc.viewControllers.first as? UINavigationController {
            svc.navigationItem.backBarButtonItem = nil
            detailView.topViewController?.navigationItem.leftBarButtonItem = nil
        }
    }
    

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let navigationController = primaryViewController as? UINavigationController else { return true }
        guard let controller = navigationController.topViewController as? NAPIListingTableViewController else { return true }
        
        return controller.collapseDetailViewController
    }
}
