//
//  ViewController.swift
//  SSLPinningDemo
//
//  Created by chander bhushan on 06/04/19.
//  Copyright © 2019 Educational. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.networkManager.pinningWithPublicKey()
        //NetworkManager.networkManager.testPinning()
    }
}

