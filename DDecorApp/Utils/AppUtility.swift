//
//  AppUtility.swift
//  DDecorApp
//
//  Created by Durgesh Pandey on 12/04/18.
//  Copyright © 2018 DDecor. All rights reserved.
//

import Foundation
import UIKit

struct StoryBoard {
    static let main: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
}

struct AppInstances {
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}
