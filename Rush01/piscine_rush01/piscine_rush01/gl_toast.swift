//
//  gl_toast.swift
//  piscine_rush01
//
//  Created by Brian Young on 6/25/17.
//  Copyright © 2017 byoung-w. All rights reserved.
//

import UIKit

class gl_toast: NSObject
{
	var controller: UIViewController? = nil

	func showToast(message : String)
	{
		if (controller == nil)
		{
			return
		}
		let toastLabel = UILabel(frame: CGRect(x: 0, y: (controller?.view.frame.size.height)! - 300, width: (controller?.view.frame.size.width)!, height: 200))
		toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		toastLabel.textColor = UIColor.white
		toastLabel.textAlignment = .center;
		toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
		toastLabel.text = message
		toastLabel.alpha = 1.0
		toastLabel.layer.cornerRadius = 10;
		toastLabel.clipsToBounds  =  false
		toastLabel.numberOfLines = 0
		controller?.view.addSubview(toastLabel)
		UIView.animate(withDuration: 30.0, delay: 0.1, options: [], animations:
		{
			toastLabel.alpha = 0.0
		}, completion:
		{(isCompleted) in
			toastLabel.removeFromSuperview()
		})
	}
}

let _TOAST_ : gl_toast = gl_toast()
