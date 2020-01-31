//
//  LoaderView.swift
//  Bandana_Pratice_2
//
//  Created by Rakesh Nangunoori on 31/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class LoaderView: NSObject {

static let shared : LoaderView = {
    let instance = LoaderView()
    return instance
}()

//Mark:- Activity Indicator
func showActivityIndicator(view: UIView, targetVC: UIViewController) {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    activityIndicator.backgroundColor = UIColor.clear
    activityIndicator.layer.cornerRadius = 6
    activityIndicator.center = targetVC.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.style = UIActivityIndicatorView.Style.medium
    activityIndicator.tag = 1
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    
}

func hideActivityIndicator(view: UIView) {
    let activityIndicator = view.viewWithTag(1) as? UIActivityIndicatorView
    activityIndicator?.stopAnimating()
    activityIndicator?.removeFromSuperview()
    
}
}
