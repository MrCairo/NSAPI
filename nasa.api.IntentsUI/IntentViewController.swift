//
//  IntentViewController.swift
//  nasa.api.intentsUI
//
//  Created by Mitchell Fisher on 12/30/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    @IBOutlet weak var apodImageView: UIImageView!
    @IBOutlet weak var apodLoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        guard interaction.intent is APODIntent else {
            completion(false, Set(), .zero)
            return
        }

        apodLoadingIndicator.startAnimating()
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        let desiredSize = CGSize(width: width, height: 300)
        let controller = ModelController<APODResponseModel>()
        controller.fetchMedia { (model) in
            guard let model = model else {
                self.apodLoadingIndicator.stopAnimating()
                completion(true, parameters, desiredSize)
                return
            }

            MediaInfoManager().fetchUrlData(with: model.url, completion: { (data) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.apodImageView.image = image
                        self.apodLoadingIndicator.stopAnimating()
                    }
                }
            })
        }

        completion(true, parameters, desiredSize)
    }

    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
