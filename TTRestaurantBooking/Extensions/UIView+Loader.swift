//
//  UIView+Loader.swift
//  BarberShop
//
//  Created by Andrii Sych on 11/1/16.
//  Copyright © 2016 ArtyGeek. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

extension UIActivityIndicatorView {
    static func startShowing() {
        guard let topViewController = UIApplication.topViewController() else { return }
        topViewController.view.isLoaderHidden = false
    }
    
    static func stopShowing() {
        guard let topViewController = UIApplication.topViewController() else { return }
        topViewController.view.isLoaderHidden = true
    }
}

extension UIView {
    var isLoaderHidden: Bool {
        get {
            return loader(withType: UIActivityIndicatorView.self) == nil
        }
        set {
            let hidden = newValue
            if hidden {
                DispatchQueue.main.async() {
                    if let loader = self.loader(withType: UIActivityIndicatorView.self) as? UIActivityIndicatorView {
                        loader.stopAnimating()
                    }
                }
            } else {
                DispatchQueue.main.async() {
                    if let loader = self.loader(withType: UIActivityIndicatorView.self) as? UIActivityIndicatorView {
                        loader.startAnimating()
                    } else {
                        let loader = UIActivityIndicatorView()
                        let viewType = type(of: self)
                        if viewType is UICollectionView.Type || viewType is UITableView.Type || viewType is UIScrollView.Type || viewType is UICollectionReusableView.Type {
                            loader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40.0)
                            loader.style = .gray
                        } else {
                            loader.frame = self.bounds
                            loader.style = .whiteLarge
                            loader.color = UIColor.lightGray
                        }
                        
                        self.addSubview(loader)
                        loader.startAnimating()
                    }
                }
            }
        }
    }
    
    private func loader(withType type: AnyObject.Type) -> UIView? {
        
        for subview in subviews.reversed() {
            if subview.isKind(of: type) {
                return subview
            }
        }
        return nil
    }
}
