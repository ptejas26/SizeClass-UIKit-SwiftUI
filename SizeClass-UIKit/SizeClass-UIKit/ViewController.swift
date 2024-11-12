//
//  ViewController.swift
//  SizeClass-UIKit
//
//  Created by Tejas Patelia on 2024-11-09.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var cancellableSet: Set<AnyCancellable> = []

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(self.traitCollection.verticalSizeClass)

        let horizontalPublisher = UIScreen.main.traitCollection.publisher(for: \.horizontalSizeClass)
        let verticalPublisher = UIScreen.main.traitCollection.publisher(for: \.verticalSizeClass)

        horizontalPublisher
            .sink { value in
                print("Current Size class Horizontal \(value.className)")
            }
            .store(in: &cancellableSet)

        verticalPublisher
            .sink { value in
                print("Current Size class Vertical \(value.className)")
            }
            .store(in: &cancellableSet)

        horizontalPublisher.combineLatest(verticalPublisher)
            .sink { [weak self] value in
                guard let self else {
                    return
                }
                self.label.text = "Size classes: \n H-\(value.0.className) V-\(value.1.className)"
            }
            .store(in: &cancellableSet)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let vertical = previousTraitCollection?.verticalSizeClass,
           let horizontal = previousTraitCollection?.horizontalSizeClass {

            let sizeClassVertical = vertical == UIUserInterfaceSizeClass(rawValue: 2) ? "Regular" : "Compact"
            let sizeClassHorizontal = horizontal == UIUserInterfaceSizeClass(rawValue: 2) ? "Regular" : "Compact"
            print("Previous Vertical: \(sizeClassVertical)")
            print("Previous Horizontal: \(sizeClassHorizontal)")
        }
    }
}

extension UIUserInterfaceSizeClass {

    enum SizeClassName: String {
        case compact
        case regular
        case unspecified
    }
    var className: SizeClassName {
        switch self {
        case .compact:
            return .compact
        case .regular:
            return .regular
        case .unspecified:
            return .unspecified
        @unknown default:
            return .unspecified
        }
    }
}
