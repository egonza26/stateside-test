//
//  ReusableView.swift
//  StatesideTest
//
//  Created by Ernesto Gonzalez on 1/22/18.
//  Copyright © 2018 Ernesto Gonzalez. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
