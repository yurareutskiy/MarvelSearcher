//
//  UIView+NSLayoutConstraint.swift
//  MarvelSearcher
//
//  Created by Reutskiy Yura on 09.03.2022.
//

import UIKit

extension UIView {
    
    /// Append a view on another view and apply constrints without margins
    func applyFitConstraints(for view: UIView, ignoreSafeArea: Bool = true, addToParentView: Bool = true) {
        applyConstraints(for: view, top: 0, left: 0, right: 0, bottom: 0, ignoreSafeArea: ignoreSafeArea, addToParentView: addToParentView)
    }
    
    /// Append a view on another view and apply constrints with optional margins
    func applyConstraints(for view: UIView, top: Double? = nil, left: Double? = nil, right: Double? = nil, bottom: Double? = nil, ignoreSafeArea: Bool = true, addToParentView: Bool = true) {
        if addToParentView {
            self.addSubview(view)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if let top = top {
            if ignoreSafeArea {
                constraints.append(view.topAnchor.constraint(equalTo: self.topAnchor, constant: top))
            } else {
                constraints.append(view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: top))
            }
        }
        if let left = left {
            constraints.append(view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left))
        }
        if let right = right {
            constraints.append(view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: right))
        }
        if let bottom = bottom {
            if ignoreSafeArea {
                constraints.append(view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom))
            } else {
                constraints.append(view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: bottom))
            }
            
        }
        NSLayoutConstraint.activate(constraints)
    }
}
