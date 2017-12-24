//
//  ViewControllerOne.swift
//  TwoTypesDataTableView
//
//  Created by Anhdzai on 12/14/17.
//  Copyright © 2017 Anhdzai. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var indexData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = indexData
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIBarButtonItem, button === saveButton {
            indexData = textField.text
        }
    }
}
