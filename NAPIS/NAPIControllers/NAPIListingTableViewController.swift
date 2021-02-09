//
//  NAPIListingTableViewController.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/27/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import UIKit
import Intents
import os

/*
 [ "APOD": "" ],
 [ "Asteroids - NeoWs": "" ],
 [ "DONKI": "" ],
 [ "EPIC": "" ],
 [ "EONET": "" ],
 [ "Earth": "" ],
 [ "Exoplanet Archive": "" ],
 [ "GeneLab Search": "" ],
 [ "NASA Image and Video Library": "" ],
 [ "Mars Rover Photos": "" ],
 [ "Satellite Situation Center": "" ],
 [ "Patents": "" ],
 [ "SSD/CNEOS": "" ],
 [ "Techport": "" ],
 [ "Vesta/Moon/Mars Trek WMTS": "" ],
 */

enum NAPIKey: String, CaseIterable {
    case about = "About"
    case apod = "APOD"
    case neos = "NEOs"
    case donki = "DONKI"
    case epic = "EPIC"
    case eonet = "EONET"
//    case earth = "Earth"
//    case exoplanet = "Exoplanets"
//    case genelab = "GeneLab"
//    case nivl = "NIVL"
//    case rover = "Red Rover"
//    case ssc = "SatSitCent"
//    case patents = "Patents"
//    case ssd_cneos = "SSD/CNEOS"
//    case techport = "Techport"
//    case trek = "Trek WMTS"
}


struct NAPIService {
    var key:NAPIKey
    var title:String
    var subTitle:String
    var storyboard:String
}


protocol NAPIServiceDelegate: class {
    func selectedService(_ newService:NAPIService)
}


class NAPIListingTableViewController: UITableViewController {
    public private(set) var services = [NAPIService]()
    public var collapseDetailViewController: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        populateServices()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        donateInteraction()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "napi_listing_cell",
                                                 for: indexPath) as! NAPIListingTableViewCell

        let service = self.services[indexPath.row]
        cell.apiTitleLabel.text = service.title
        cell.apiFullNameLabel.text = service.subTitle

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        self.collapseDetailViewController = false

        if let rightNavigation = splitViewController?.viewControllers.last as? UINavigationController,
           let detail = rightNavigation.viewControllers.first as? NAPIDetailViewController {
            
            detail.selectedService(service)
        }
    }


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        // The user has selected an item from the tableView. Get the selection
        // and populate the handoff controller
        //
        guard let destination = segue.destination as? UINavigationController else { return }
        guard let index = self.tableView.indexPathForSelectedRow else { return }
        guard let vc = destination.viewControllers.first as? NAPIDetailViewController else { return }

        let service = services[index.row]
        vc.selectedService(service)
        vc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        vc.navigationItem.leftItemsSupplementBackButton = true
    }

    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if (activity.activityType == "APODIntent") {
            self.tableView.selectRow(at: IndexPath(row: 1, section: 0),
                                     animated: true,
                                     scrollPosition:UITableView.ScrollPosition.top)
            self.performSegue(withIdentifier: "SelectedAPISegue", sender: self)
        }
    }

    private func populateServices() {
        services.append(NAPIService(key: .about,
                                    title: NAPIKey.about.rawValue,
                                    subTitle: "About this as well as generic settings",
                                    storyboard: "About"))
        
        services.append(NAPIService(key: .apod,
                                    title: NAPIKey.apod.rawValue,
                                    subTitle: "Astronomy Picture of the Day",
                                    storyboard: "APOD"))
        
//        services.append(NAPIService(key: .neos,
//                                    title: NAPIKey.neos.rawValue,
//                                    subTitle: "Near Earth Objects",
//                                    storyboard: ""))
//
//        services.append(NAPIService(key: .donki,
//                                    title: NAPIKey.donki.rawValue,
//                                    subTitle: "Database Of Notifications, Knowledge, Information",
//                                    storyboard: ""))
//
//        services.append(NAPIService(key: .epic,
//                                    title: NAPIKey.epic.rawValue,
//                                    subTitle: "Earth Polychromatic Imaging Camera",
//                                    storyboard: ""))
//
//        services.append(NAPIService(key: .eonet,
//                                    title: NAPIKey.eonet.rawValue,
//                                    subTitle: "Earth Observatory Natural Event Tracker",
//                                    storyboard: ""))
    }
    
    fileprivate func donateInteraction() {
        let intent = NAPISIntent()
        intent.suggestedInvocationPhrase = "Open NAPIS"
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    os_log("Interaction donation failed: %@", log: OSLog.default, type: .error, error)
                } else {
                    os_log("Successfully donated interaction")
                }
            }
        }
    }

}
