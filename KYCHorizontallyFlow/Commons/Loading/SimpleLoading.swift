//
//  SimpleLoading.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 23/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class SimpleLoading {
    
    func showLoading() {
        
        let loading = UIView(frame: UIScreen.main.bounds)
        let spinner = UIActivityIndicatorView()
        
        loading.addSubview(spinner)
        loading.backgroundColor = Color(hexString: "#000", alpha: 0.7).color
        
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: loading.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loading.centerYAnchor).isActive = true
        spinner.startAnimating()
        
        UIApplication.shared.keyWindow?.endEditing(true)
        UIApplication.shared.keyWindow?.addSubview(loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            loading.removeFromSuperview()
        }
    }
}
