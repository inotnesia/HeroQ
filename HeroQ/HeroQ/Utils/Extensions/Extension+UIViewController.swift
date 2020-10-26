//
//  Extension+UIViewController.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 26/10/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.heroQPrimaryColor
        navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
