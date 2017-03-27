//
//  APIUTILS.swift
//  App_SocialFrameworks_Facebook_Twitter
//
//  Created by formador on 27/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import Foundation
import UIKit

func muestraAlertVC(_ titleData : String, messageData : String, titleAction : String) -> UIAlertController{
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: titleAction, style: .default, handler: nil))
    return alert
}

