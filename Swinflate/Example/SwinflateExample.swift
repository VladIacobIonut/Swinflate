//
//  SwinflateExample.swift
//  Example
//
//  Created by Vlad on 1/7/19.
//  Copyright © 2019 Vlad Iacob. All rights reserved.
//

import UIKit

enum SwinflateExamples: String, CaseIterable {
    case inflate = "Inflate"
    case stack = "Horizontal stack"

    var viewController: UIViewController {
        switch self {
        case .stack:
            let stackVC = StackLayoutViewController()
            stackVC.title = self.rawValue
            return stackVC
        case .inflate:
            let inflateVC = InflateLayoutViewController()
            inflateVC.title = self.rawValue
            return inflateVC
        }
    }
}
