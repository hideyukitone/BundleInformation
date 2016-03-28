//
//  ViewController.swift
//  BundleInformationSample
//
//  Created by hideyukitone on 2016/03/23.
//  Copyright © 2016年 hideyuki. All rights reserved.
//

import UIKit
import BundleInformation

class ViewController: UIViewController {

    @IBOutlet weak var lblDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appName = BundleInformation.appDisplayName ?? BundleInformation.moduleName(delegate: UIApplication.sharedApplication().delegate) ?? ""
        lblDisplay.text = "\(appName)\n\(BundleInformation.version)(\(BundleInformation.build))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

