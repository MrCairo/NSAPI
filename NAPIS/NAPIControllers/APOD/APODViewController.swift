//
//  APODViewController.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/27/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import UIKit
import IntentsUI
import os
import WebKit

class APODViewController: NAPIBaseViewController, INUIAddVoiceShortcutViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var apodTitle: UILabel!
    @IBOutlet weak var apodDescriptionTextView: UITextView!
    @IBOutlet weak var siriButton: UIButton!

    var apodResults: APODResponseModel?
    private var apodShortcutIsActive:Bool = false
    
    fileprivate let controller = ModelController<APODResponseModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apodTitle.text = ""
        apodDescriptionTextView.text = "Loading..."
        siriButton.isHidden = true
        webView.isHidden = true
        title = "APOD"
        
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (shortcuts, error) in
            if error == nil {
                
                let shortcut = shortcuts?.first(where: { (item) -> Bool in
                    return (item.shortcut.intent is APODIntent)
                })
                
                self.apodShortcutIsActive = (shortcut != nil)
            }
        }

        donateInteraction()
        fetchAPOD()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        controller.manager.cancel()
    }


    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
    }


    @IBAction func addToSiri(_ sender: Any) {
        let intent = APODIntent()
        intent.suggestedInvocationPhrase = "Today's Astro Photo"
        if let shortcut = INShortcut(intent: intent) {
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self // Object conforming to `INUIAddVoiceShortcutViewControllerDelegate`.
            present(viewController, animated: true, completion: nil)
        }
    }


    func serviceComplete(_ results:APODResponseModel?) {
        if let data = results {
            DispatchQueue.main.async {
                if data.isImage {
                    self.webView.isHidden = true
                    self.imageView.isHidden = false
                    self.controller.fetchData(fromUrl: data.url) { (data) in
                        guard
                            let data = data,
                            let image = UIImage(data: data)
                            else { return }

                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.siriButton?.isEnabled = true
                            self.siriButton.isHidden = self.apodShortcutIsActive
                        }
                    }
                } else if data.isVideo {
                    self.webView.isHidden = false
                    self.imageView.isHidden = true
                    self.webView.load(URLRequest(url: data.url))
                }
            }
        }
        print("Service returned")
    }
    
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (shortcuts, error) in
            if error == nil {
                
                let shortcut = shortcuts?.first(where: { (item) -> Bool in
                    return (item.shortcut.intent is APODIntent)
                })
                DispatchQueue.main.sync {
                    self.apodShortcutIsActive = (shortcut != nil)
                    self.siriButton.isHidden = self.apodShortcutIsActive
                }
            }
        }
    }


    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }


    fileprivate func donateInteraction() {
        let intent = APODIntent()
        intent.suggestedInvocationPhrase = "Astro Photo"
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
    
    
    fileprivate func fetchAPOD() {
        self.siriButton?.isEnabled = false
        controller.fetchMedia { (apodModel:APODResponseModel?) in
            if let model = apodModel {
                DispatchQueue.main.async {
                    self.apodTitle.text = model.title
                    self.apodDescriptionTextView.text = model.description
                }
            }
            self.serviceComplete(apodModel)
        }
    }
    
    fileprivate func loadVideo(videoURL: URL) {
        // create a custom youtubeURL with the video ID
//        guard
//            let url = NSURL(string: "https://www.youtube.com/embed/\(videoID)")
//            else { return }
        // load your web request
        webView.load(URLRequest(url: videoURL))
    }
}
