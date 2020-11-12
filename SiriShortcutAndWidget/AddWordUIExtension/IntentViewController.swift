//
//  IntentViewController.swift
//  AddWordUIExtension
//
//  Created by astafeev on 11/12/20.
//

import IntentsUI
import AddWordKit

class IntentViewController: UIViewController, INUIHostedViewControlling {
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {

        guard let intent = interaction.intent as? AddWordIntent else {
            completion(false, Set(), .zero)
            return
        }

        if interaction.intentHandlingStatus == .success {
            let viewController = ResultViewController(for: intent)
            attachChild(viewController)
            completion(true, parameters, desiredSize)
        } else {
            completion(false, parameters, .zero)
        }

        completion(false, parameters, .zero)
    }

    private var desiredSize: CGSize {
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        return CGSize(width: width, height: 180)
    }

    private func attachChild(_ viewController: UIViewController) {
        addChild(viewController)

        if let subview = viewController.view {
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false

            // Set the child controller's view to be the exact same size as the parent controller's view.
            subview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            subview.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

            subview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }

        viewController.didMove(toParent: self)
    }
    
}
