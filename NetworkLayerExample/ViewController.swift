//
//  ViewController.swift
//  NetworkLayerExample
//
//  Created by Canh Tran Wizeline on 8/8/19.
//  Copyright © 2019 Canh Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LoginViewModel.shared.testLogin()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
